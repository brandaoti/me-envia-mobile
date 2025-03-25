enum PackageStatus {
  awaitingFee,
  awaitingPayment,
  paymentAccept,
  paymentRefused,
  paymentSubjectToConfirmation,
}

extension PackageStatusExtension on PackageStatus {
  String get value {
    switch (this) {
      case PackageStatus.awaitingFee:
        return 'Aguardando Taxa';
      case PackageStatus.awaitingPayment:
        return 'Aguardando o pagamento!';
      case PackageStatus.paymentSubjectToConfirmation:
        return 'Pagamento sujeito a confirmação!';
      case PackageStatus.paymentAccept:
        return 'Pagamento Aprovado!';
      case PackageStatus.paymentRefused:
        return 'Pagamento Recusado!';
      default:
        return 'Aguardando Taxa';
    }
  }
}

extension JsonPackageStatusExtension on String {
  PackageStatus? get fromStatus {
    if (this == PackageStatus.awaitingFee.value) {
      return PackageStatus.awaitingFee;
    } else if (this == PackageStatus.awaitingPayment.value) {
      return PackageStatus.awaitingPayment;
    } else if (this == PackageStatus.paymentAccept.value) {
      return PackageStatus.paymentAccept;
    } else if (this == PackageStatus.paymentRefused.value) {
      return PackageStatus.paymentRefused;
    } else if (this == PackageStatus.paymentSubjectToConfirmation.value) {
      return PackageStatus.paymentSubjectToConfirmation;
    } else {
      return PackageStatus.awaitingFee;
    }
  }
}
