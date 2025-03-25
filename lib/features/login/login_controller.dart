import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';
import 'states/login_state.dart';

abstract class LoginController {
  Stream<bool> get isPasswordVisibleStream;
  Stream<LoginState> get loginStateStream;

  void togglePasswordVisible(bool value);

  void dispose();
  Future<void> handleSubmit(String email, String password);
}

class LoginControllerImpl implements LoginController {
  final AuthController authController;
  final AuthRepository authRepository;

  LoginControllerImpl({
    required this.authController,
    required this.authRepository,
  });

  final _loginStateStream = BehaviorSubject<LoginState>.seeded(
    LoginInitialState(),
  );

  final _isPasswordVisibleSubject = BehaviorSubject<bool>.seeded(true);

  @override
  Stream<LoginState> get loginStateStream =>
      _loginStateStream.stream.distinct();

  @override
  Stream<bool> get isPasswordVisibleStream =>
      _isPasswordVisibleSubject.stream.distinct();

  @override
  void togglePasswordVisible(bool value) {
    if (!_isPasswordVisibleSubject.isClosed) {
      _isPasswordVisibleSubject.add(value);
    }
  }

  void onChangeLoginState(LoginState newState) {
    if (!_loginStateStream.isClosed) {
      _loginStateStream.add(newState);
    }
  }

  void navigateTo(String token) async {
    await authController.saveToken(token);
    await authController.init();

    final isFirstTimeBoardingTheApp =
        await authController.getisFirstTimeBoardingTheApp();

    if (isFirstTimeBoardingTheApp) {
      Modular.to.pushReplacementNamed(
        RoutesName.tutorial.name,
        arguments: true,
      );
    } else {
      Modular.to.pushReplacementNamed(RoutesName.tabs.name);
    }

    onChangeLoginState(LoginSucessState());
  }

  @override
  Future<void> handleSubmit(String email, String password) async {
    onChangeLoginState(LoginLoadingState());

    try {
      final loginResquest = LoginRequest(
        email: email.trim(),
        password: password.trim(),
      );

      final token = await authRepository.login(loginResquest);

      navigateTo(token);
    } on ApiClientError catch (e) {
      onChangeLoginState(LoginErrorState(message: e.message ?? ''));
    }
  }

  @override
  void dispose() {
    _loginStateStream.close();
    _isPasswordVisibleSubject.close();
  }
}
