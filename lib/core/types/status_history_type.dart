enum StatusHistoryType {
  delivered,
  posted,
  other,
}

extension StatusHistoryTypeExtension on StatusHistoryType {
  String get statusTypeValue {
    switch (this) {
      case StatusHistoryType.delivered:
        return 'Objeto entregue ao destinatário';
      case StatusHistoryType.posted:
        return 'Objeto postado';
      case StatusHistoryType.other:
        return '';
    }
  }
}

extension JsonStatusHistoryTypeExtension on String? {
  StatusHistoryType get fromStatusHistoryType {
    if (this == StatusHistoryType.delivered.statusTypeValue) {
      return StatusHistoryType.delivered;
    } else if (this == StatusHistoryType.posted.statusTypeValue) {
      return StatusHistoryType.posted;
    } else {
      return StatusHistoryType.other;
    }
  }
}
