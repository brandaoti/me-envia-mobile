import 'package:rxdart/rxdart.dart';

import '../../core/client/client.dart';
import '../../core/repositories/repositories.dart';
import 'states/forgot_password_states.dart';

abstract class ForgotPasswordController {
  Stream<ForgotPasswordState> get forgotPasswordStateStream;

  void dispose();
  Future<void> handleSendEmail(String email);
}

class ForgotPasswordControllerImpl implements ForgotPasswordController {
  final AuthRepository authRepository;

  ForgotPasswordControllerImpl({
    required this.authRepository,
  });

  final _forgotPasswordStateSubject =
      BehaviorSubject<ForgotPasswordState>.seeded(
    ForgotPasswordInitialState(),
  );

  @override
  Stream<ForgotPasswordState> get forgotPasswordStateStream =>
      _forgotPasswordStateSubject.stream.distinct();

  void onChangeForgotPasswordState(ForgotPasswordState newState) {
    if (!_forgotPasswordStateSubject.isClosed) {
      _forgotPasswordStateSubject.add(newState);
    }
  }

  @override
  Future<void> handleSendEmail(String email) async {
    onChangeForgotPasswordState(ForgotPasswordLoadingState());

    try {
      await authRepository.forgotPassword(email.trim());
      onChangeForgotPasswordState(ForgotPasswordSucessState());
    } on ApiClientError catch (e) {
      onChangeForgotPasswordState(ForgotPasswordErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    _forgotPasswordStateSubject.close();
  }
}
