import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

import '../../../../core/repositories/repositories.dart';
import '../../core/client/client.dart';
import 'states/faq_state.dart';
import 'states/general_information_state.dart';

abstract class GeneralInformationController extends Disposable {
  Stream<FaqState> get faqStateStream;
  Stream<GeneralInformationState> get informationStateStream;

  Future<void> handleGetAllFaq();
  void init(MariaInformationParams params);
}

class GeneralInformationControllerImpl implements GeneralInformationController {
  final GeneralInformationRepository repository;

  GeneralInformationControllerImpl({
    required this.repository,
  });

  final _informationStateSubject =
      BehaviorSubject<GeneralInformationState>.seeded(
    GeneralInformationLoadingState(),
  );

  final _faqStateSubject = BehaviorSubject<FaqState>.seeded(
    FaqStateLoadingState(),
  );

  @override
  Stream<GeneralInformationState> get informationStateStream =>
      _informationStateSubject.stream.distinct();

  @override
  Stream<FaqState> get faqStateStream => _faqStateSubject.stream.distinct();

  @override
  void init(MariaInformationParams params) async {
    await loadGeneralInformation(params);
  }

  void onChangeGeneralInformationState(GeneralInformationState newState) {
    if (!_informationStateSubject.isClosed) {
      _informationStateSubject.add(newState);
    }
  }

  Future<void> loadGeneralInformation(MariaInformationParams params) async {
    onChangeGeneralInformationState(GeneralInformationLoadingState());

    try {
      final result = await repository.getMariaInformation(params: params);
      onChangeGeneralInformationState(GeneralInformationSucessState(
        information: result,
      ));
    } on ApiClientError catch (e) {
      onChangeGeneralInformationState(GeneralInformationErrorState(
        message: e.message ?? '',
      ));
    }
  }

  void onChangeFaqState(FaqState newState) {
    if (!_faqStateSubject.isClosed) {
      _faqStateSubject.add(newState);
    }
  }

  @override
  Future<void> handleGetAllFaq() async {
    onChangeFaqState(FaqStateLoadingState());

    try {
      final result = await repository.getAllFaq();
      onChangeFaqState(FaqStateSucessState(list: result));
    } on ApiClientError catch (e) {
      onChangeFaqState(FaqStateErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    _faqStateSubject.close();
    _informationStateSubject.close();
  }
}
