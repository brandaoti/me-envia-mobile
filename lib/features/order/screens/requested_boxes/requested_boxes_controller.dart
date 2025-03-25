import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

import '../../states/requested_box_states.dart';
import '../../../../core/core.dart';

abstract class RequestedBoxController {
  Stream<RequestedBoxState> get requestedBoxStream;

  void init(PackageSection newSection);
  void dispose();

  void navigateToCheckoutPayment(Package package);

  Future<void> handleRequestedBox();
}

class RequestedBoxImpl implements RequestedBoxController {
  final GeneralInformationRepository repository;

  RequestedBoxImpl({
    required this.repository,
  });

  late PackageSection section;

  final _requestedBoxStateStream = BehaviorSubject<RequestedBoxState>.seeded(
    RequestedBoxLoadingState(),
  );

  @override
  Stream<RequestedBoxState> get requestedBoxStream =>
      _requestedBoxStateStream.stream.distinct();

  @override
  void init(PackageSection newSection) async {
    section = newSection;
    await handleRequestedBox();
  }

  void onChangeRequestedBoxState(RequestedBoxState newState) {
    if (!_requestedBoxStateStream.isClosed) {
      _requestedBoxStateStream.add(newState);
    }
  }

  @override
  Future<void> handleRequestedBox() async {
    onChangeRequestedBoxState(RequestedBoxLoadingState());

    try {
      final result = await repository.getPackages(section: section);
      onChangeRequestedBoxState(RequestedBoxSucessState(
        pack: result,
      ));
    } on ApiClientError catch (e) {
      onChangeRequestedBoxState(RequestedBoxErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void navigateToCheckoutPayment(Package package) {
    Modular.to.pushNamed(
      RoutesName.checkoutPayment.linkNavigate,
      arguments: package,
    );
  }

  @override
  void dispose() {
    _requestedBoxStateStream.close();
  }
}
