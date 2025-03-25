import '../../core.dart';

class PackageStatusHistory {
  final BoxList items;
  final String packageId;
  final String? trackingCode;
  final StatusHistoryList status;

  const PackageStatusHistory({
    required this.items,
    required this.status,
    required this.packageId,
    required this.trackingCode,
  });

  factory PackageStatusHistory.fromJson(Map json) {
    final itemsList = json['items'] as List;
    final statusList = (json['statusHistory'] as List)
        .map((it) => StatusHistory.fromJson(it))
        .toList();

    return PackageStatusHistory(
      packageId: json['packageId'],
      trackingCode: json['trackingCode'],
      status: statusList..sortByStatusDate,
      items: itemsList.map((it) => Box.fromPackageStatus(it)).toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageStatusHistory &&
        other.items == items &&
        other.packageId == packageId &&
        other.trackingCode == trackingCode &&
        other.status == status;
  }

  @override
  int get hashCode {
    return items.hashCode ^
        packageId.hashCode ^
        trackingCode.hashCode ^
        status.hashCode;
  }

  @override
  String toString() {
    return 'PackageStatusHistory(items: $items, packageId: $packageId, trackingCode: $trackingCode, status: $status)';
  }
}
