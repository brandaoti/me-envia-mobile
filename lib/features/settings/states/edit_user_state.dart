abstract class EditUserState {}

class EditUserLoadingState implements EditUserState {
  const EditUserLoadingState();
}

class EditUserSuccessState implements EditUserState {
  const EditUserSuccessState();
}

class EditUserErrorState implements EditUserState {
  final String? message;

  const EditUserErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditUserErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
