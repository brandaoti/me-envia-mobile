import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'package:maria_me_envia/core/core.dart';

import '../features.dart';
import 'states/open_proof_of_payment_state.dart';
import 'states/upload_file_state.dart';

abstract class CheckoutPaymentController extends Disposable {
  Stream<UploadFileState> get uploadFileStateStream;
  Stream<OpenProofOfPaymentState> get openProofOfPaymentStateStream;

  void init(Package package);

  void navigateToOrderScreen();
  void handleCopyAddress(BuildContext context);

  Future<void> handleUploadFile();
  Future<void> handleGetFileInDocument();
}

class CheckoutPaymentControllerImpl implements CheckoutPaymentController {
  final PutFileService service;
  final GeneralInformationRepository repository;

  CheckoutPaymentControllerImpl({
    required this.service,
    required this.repository,
  });

  late PutFile proofOfPayment;
  late final String packageId;

  final _proofOfPaymentSuject = BehaviorSubject<OpenProofOfPaymentState>.seeded(
    OpenProofOfPaymentInitalState(),
  );

  final _uploadFileSuject = BehaviorSubject<UploadFileState>();

  @override
  Stream<OpenProofOfPaymentState> get openProofOfPaymentStateStream =>
      _proofOfPaymentSuject.stream.distinct();

  @override
  Stream<UploadFileState> get uploadFileStateStream =>
      _uploadFileSuject.stream.distinct();

  @override
  void init(Package package) {
    packageId = package.id;
  }

  void onChangeOpenProofOfPaymentState(OpenProofOfPaymentState newState) {
    if (!_proofOfPaymentSuject.isClosed) {
      _proofOfPaymentSuject.add(newState);
    }
  }

  @override
  Future<void> handleGetFileInDocument() async {
    try {
      proofOfPayment = await service.getFile();
      onChangeOpenProofOfPaymentState(OpenProofOfPaymentSucessState(
        fileName: proofOfPayment.proofOfPayment,
      ));
    } on ApiClientError catch (e) {
      onChangeOpenProofOfPaymentState(OpenProofOfPaymentErrorState(
        message: e.message ?? '',
      ));
    } 
  }

  void onChangeUploadFileState(UploadFileState newState) {
    if (!_uploadFileSuject.isClosed) {
      _uploadFileSuject.add(newState);
    }
  }

  @override
  Future<void> handleUploadFile() async {
    onChangeUploadFileState(UploadFileLoadingState());

    try {
      await repository.uploadProofOfPayment(
        packageId: packageId,
        putFile: proofOfPayment,
      );
      onChangeUploadFileState(UploadFileSucessState());
    } on ApiClientError catch (e) {
      onChangeUploadFileState(UploadFileErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void handleCopyAddress(BuildContext context) {
    Helper.copyToClipboard(Strings.informationOfPayment.join(' '));
    Helper.showSnackBarCopiedToClipboard(context, Strings.paymentInfoMessage);
  }

  @override
  void navigateToOrderScreen() async {
    await Future.delayed(Durations.transitionToNavigate);
    Modular.to.pushReplacementNamed(
      RoutesName.tabs.name,
      arguments: TabScreenParams.sendBox(),
    );
  }

  @override
  void dispose() {
    _uploadFileSuject.close();
    _proofOfPaymentSuject.close();
  }
}
