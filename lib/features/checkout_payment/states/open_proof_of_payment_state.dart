abstract class OpenProofOfPaymentState {}

class OpenProofOfPaymentInitalState implements OpenProofOfPaymentState {}

class OpenProofOfPaymentSucessState implements OpenProofOfPaymentState {
  final String fileName;

  const OpenProofOfPaymentSucessState({
    required this.fileName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenProofOfPaymentSucessState && other.fileName == fileName;
  }

  @override
  int get hashCode => fileName.hashCode;

  @override
  String toString() => 'OpenProofOfPaymentSucessState(fileName: $fileName)';
}

class OpenProofOfPaymentErrorState implements OpenProofOfPaymentState {
  final String message;

  const OpenProofOfPaymentErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenProofOfPaymentErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'OpenProofOfPaymentErrorState(message: $message)';
}
