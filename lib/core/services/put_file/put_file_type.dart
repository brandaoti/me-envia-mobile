enum PutFileType {
  pdf,
  jpg,
  jpeg,
  png,
}

extension PutFileTypeExtension on PutFileType {
  String get value {
    switch (this) {
      case PutFileType.pdf:
        return 'pdf';
      case PutFileType.jpg:
        return 'jpg';
      case PutFileType.jpeg:
        return 'jpeg';
      case PutFileType.png:
        return 'png';
      default:
        return 'png';
    }
  }
}

extension JsonPutFileTypeExtension on String {
  PutFileType get fromPutFileType {
    if (this == PutFileType.pdf.value) {
      return PutFileType.pdf;
    } else if (this == PutFileType.jpeg.value) {
      return PutFileType.jpeg;
    } else if (this == PutFileType.jpg.value) {
      return PutFileType.jpg;
    } else if (this == PutFileType.png.value) {
      return PutFileType.png;
    } else {
      return PutFileType.pdf;
    }
  }
}

extension PutFileTypeApiExtension on PutFileType {
  String get toMediaType {
    switch (this) {
      case PutFileType.pdf:
        return 'application/pdf';
      case PutFileType.jpeg:
        return 'image/jpeg';
      case PutFileType.jpg:
        return 'image/jpg';
      case PutFileType.png:
        return 'image/png';
      default:
        return 'application/pdf';
    }
  }
}
