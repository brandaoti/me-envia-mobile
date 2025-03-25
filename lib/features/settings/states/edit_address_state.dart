abstract class EditAddressState {}

class EditAddressLoadingState implements EditAddressState {
  const EditAddressLoadingState();
}

class EditAddressSuccessState implements EditAddressState {
  const EditAddressSuccessState();
}

class EditAddressErrorState implements EditAddressState {
  final String? message;

  const EditAddressErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditAddressErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
