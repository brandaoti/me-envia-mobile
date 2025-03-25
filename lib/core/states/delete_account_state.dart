abstract class DeleteAccountState {}

class DeleteAccountInitialState implements DeleteAccountState {
  const DeleteAccountInitialState();
}

class DeleteAccountLoadingState implements DeleteAccountState {
  const DeleteAccountLoadingState();
}

class DeleteAccountSuccessState implements DeleteAccountState {
  const DeleteAccountSuccessState();
}

class DeleteAccountErrorState implements DeleteAccountState {
  final String? message;

  const DeleteAccountErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeleteAccountErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
