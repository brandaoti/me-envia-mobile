abstract class LoginState {}

class LoginInitialState implements LoginState {}

class LoginLoadingState implements LoginState {}

class LoginSucessState implements LoginState {}

class LoginErrorState implements LoginState {
  final String message;

  const LoginErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
