abstract class UploadFileState {}

class UploadFileLoadingState implements UploadFileState {}

class UploadFileSucessState implements UploadFileState {}

class UploadFileErrorState implements UploadFileState {
  final String message;

  const UploadFileErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadFileErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'UploadFileErrorState(message: $message)';
}
