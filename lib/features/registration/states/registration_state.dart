abstract class RegistrationState {}

class RegistrationLoadingState implements RegistrationState {}

class RegistrationSuccessState implements RegistrationState {}

class RegistrationErrorState implements RegistrationState {
  final String? message;

  const RegistrationErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistrationErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
