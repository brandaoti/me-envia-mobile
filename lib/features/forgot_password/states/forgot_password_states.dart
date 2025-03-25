abstract class ForgotPasswordState {}

class ForgotPasswordInitialState implements ForgotPasswordState {}

class ForgotPasswordLoadingState implements ForgotPasswordState {}

class ForgotPasswordSucessState implements ForgotPasswordState {}

class ForgotPasswordErrorState implements ForgotPasswordState {
  final String message;

  const ForgotPasswordErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ForgotPasswordErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
