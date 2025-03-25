enum PackageType {
  success,
  warning,
}

extension PackageTypeExtension on PackageType {
  String get value {
    switch (this) {
      case PackageType.success:
        return 'SUCCESS';
      case PackageType.warning:
        return 'WARNING';
      default:
        return 'WARNING';
    }
  }
}

extension JsonPackageTypeExtension on String {
  PackageType? get fromType {
    if (this == PackageType.success.value) {
      return PackageType.success;
    } else if (this == PackageType.warning.value) {
      return PackageType.warning;
    } else {
      return null;
    }
  }
}
