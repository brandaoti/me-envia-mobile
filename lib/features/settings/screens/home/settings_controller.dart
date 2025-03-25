import 'package:rxdart/rxdart.dart';
import '../../../../core/core.dart';

abstract class SenttingsController {
  Stream<DeleteAccountState> get deleteAccountStateStream;

  Future<void> handleLogout();
  Future<void> handleDeleteAccount();

  void init();
  void dispose();
}

class SenttingsControllerImpl implements SenttingsController {
  final AuthRepository repository;
  final AuthController authController;

  SenttingsControllerImpl({
    required this.repository,
    required this.authController,
  });

  final _deleteUserSubject = BehaviorSubject<DeleteAccountState>.seeded(
    const DeleteAccountInitialState(),
  );

  @override
  Stream<DeleteAccountState> get deleteAccountStateStream =>
      _deleteUserSubject.stream.distinct();

  @override
  void init() {
    onChangeDeleteAccountState(const DeleteAccountInitialState());
  }

  void onChangeDeleteAccountState(DeleteAccountState newState) {
    if (!_deleteUserSubject.isClosed) {
      _deleteUserSubject.add(newState);
    }
  }

  @override
  Future<void> handleDeleteAccount() async {
    onChangeDeleteAccountState(const DeleteAccountLoadingState());

    try {
      await repository.deleteAccount();
      handleStateSuccess();

      onChangeDeleteAccountState(const DeleteAccountSuccessState());
    } on ApiClientError catch (e) {
      onChangeDeleteAccountState(DeleteAccountErrorState(
        message: e.message,
      ));
    }
  }

  void handleStateSuccess() async {
    await Future.delayed(Durations.transitionToNavigate);
    await handleLogout();
  }

  @override
  Future<void> handleLogout() async {
    await authController.logout();
  }

  @override
  void dispose() {
    _deleteUserSubject.close();
  }
}
