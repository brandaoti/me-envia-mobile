enum PackageStep {
  notSend,
  send,
  arrivedInbrazil,
  inTransit,
  delivered,
}

extension StepsExtension on PackageStep {
  String get stepValue {
    switch (this) {
      case PackageStep.notSend:
        return 'NOT_SENT';
      case PackageStep.send:
        return 'SENT';
      case PackageStep.arrivedInbrazil:
        return 'ARRIVED_IN_BRAZIL';
      case PackageStep.inTransit:
        return 'IN_TRANSIT';
      case PackageStep.delivered:
        return 'DELIVERED';
      default:
        return 'NOT_SENT';
    }
  }
}

extension JsonStepsExtension on String? {
  PackageStep? get fromApiStep {
    if (this == PackageStep.notSend.stepValue) {
      return PackageStep.notSend;
    } else if (this == PackageStep.send.stepValue) {
      return PackageStep.send;
    } else if (this == PackageStep.arrivedInbrazil.stepValue) {
      return PackageStep.arrivedInbrazil;
    } else if (this == PackageStep.inTransit.stepValue) {
      return PackageStep.inTransit;
    } else if (this == PackageStep.delivered.stepValue) {
      return PackageStep.delivered;
    } else {
      return null;
    }
  }
}
