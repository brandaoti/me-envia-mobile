import '../../core.dart';

typedef StatusHistoryList = List<StatusHistory>;

class StatusHistory {
  final String status;
  final String statusLocal;
  final DateTime statusDate;
  final StatusHistoryType statusType;

  StatusHistory({
    required this.status,
    required this.statusLocal,
    required this.statusDate,
    required this.statusType,
  });

  factory StatusHistory.fromJson(Map json) {
    return StatusHistory(
      status: json['status'],
      statusLocal: json['statusLocal'],
      statusType: (json['status'] as String).fromStatusHistoryType,
      statusDate: Helper.packgeStatusParseToDateTime(
        json['statusDate'],
        json['statusTime'],
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusHistory &&
        other.status == status &&
        other.statusLocal == statusLocal &&
        other.statusDate == statusDate &&
        other.statusType == statusType;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        statusLocal.hashCode ^
        statusDate.hashCode ^
        statusType.hashCode;
  }

  @override
  String toString() {
    return 'StatusHistory(status: $status, statusLocal: $statusLocal, statusDate: $statusDate, statusType: $statusType)';
  }
}
