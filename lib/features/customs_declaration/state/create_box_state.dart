abstract class CreateBoxState {}

class CreateBoxLoadingState implements CreateBoxState {}

class CreateBoxSucessState implements CreateBoxState {}

class CreateBoxErrorState implements CreateBoxState {
  final String message;

  const CreateBoxErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateBoxErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
