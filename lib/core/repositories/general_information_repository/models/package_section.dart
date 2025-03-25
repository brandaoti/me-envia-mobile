enum PackageSection { created, pending, sent }

extension PackageSectionExtension on PackageSection {
  String get value {
    switch (this) {
      case PackageSection.created:
        return 'created';
      case PackageSection.pending:
        return 'pending';
      case PackageSection.sent:
        return 'sent';
      default:
        return 'created';
    }
  }

  String get fromApi {
    return '?section=$value';
  }
}

extension JsonPackageSectionExtension on String {
  PackageSection get fromJson {
    if (this == PackageSection.created.value) {
      return PackageSection.created;
    } else if (this == PackageSection.pending.value) {
      return PackageSection.pending;
    } else if (this == PackageSection.sent.value) {
      return PackageSection.sent;
    } else {
      return PackageSection.created;
    }
  }
}
