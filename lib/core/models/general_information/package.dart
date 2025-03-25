import '../../helpers/extensions.dart';
import '../../types/types.dart';

typedef PackageList = List<Package>;

class Package {
  final String id;
  final String totalItems;
  final int? shippingFee;
  final PackageType? type;
  final PackageStep? step;
  final String? status;
  final PackageStatus? packageStatus;
  final num? declaredTotal;
  final String? trackingCode;
  final String? paymentVoucher;
  final DateTime updateAt;
  final DateTime createdAt;
  final String? lastPackageUpdateLocation;

  const Package({
    required this.id,
    required this.totalItems,
    required this.shippingFee,
    required this.type,
    required this.step,
    required this.status,
    required this.packageStatus,
    required this.declaredTotal,
    required this.trackingCode,
    required this.paymentVoucher,
    required this.updateAt,
    required this.createdAt,
    required this.lastPackageUpdateLocation,
  });

  factory Package.fromJson(Map json) {
    final now = DateTime.now().subtract(const Duration(hours: 3));

    DateTime? updateDate;
    DateTime? creationDate;

    if (json['updatedAt'] != null) {
      updateDate = DateTime.parse(json['updatedAt']);
    }

    if (json['createdAt'] != null) {
      creationDate = DateTime.parse(json['createdAt']);
    }

    return Package(
      id: json['id'],
      status: json['status'],
      updateAt: updateDate ?? now,
      createdAt: creationDate ?? now,
      totalItems: json['totalItems'],
      shippingFee: json['shippingFee'],
      trackingCode: json['trackingCode'],
      declaredTotal: json['declaredTotal'],
      type: (json['type'] as String).fromType,
      step: (json['step'] as String).fromApiStep,
      packageStatus: (json['status'] as String).fromStatus,
      lastPackageUpdateLocation: json['lastPackageUpdateLocation'],
      paymentVoucher: (json['paymentVoucher'] as String).normalizePictureUrl,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'status': status,
      'step': type?.value,
      'type': step?.stepValue,
      'totalItems': totalItems,
      'shippingFee': shippingFee,
      'trackingCode': trackingCode,
      'paymentVoucher': paymentVoucher,
      'packageStatus': packageStatus?.value,
      'lastPackageUpdateLocation': lastPackageUpdateLocation,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Package &&
        other.id == id &&
        other.totalItems == totalItems &&
        other.shippingFee == shippingFee &&
        other.type == type &&
        other.step == step &&
        other.status == status &&
        other.packageStatus == packageStatus &&
        other.declaredTotal == declaredTotal &&
        other.trackingCode == trackingCode &&
        other.paymentVoucher == paymentVoucher &&
        other.updateAt == updateAt &&
        other.createdAt == createdAt &&
        other.lastPackageUpdateLocation == lastPackageUpdateLocation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        totalItems.hashCode ^
        shippingFee.hashCode ^
        type.hashCode ^
        step.hashCode ^
        status.hashCode ^
        packageStatus.hashCode ^
        declaredTotal.hashCode ^
        trackingCode.hashCode ^
        paymentVoucher.hashCode ^
        updateAt.hashCode ^
        createdAt.hashCode ^
        lastPackageUpdateLocation.hashCode;
  }

  @override
  String toString() {
    return 'Package(id: $id, totalItems: $totalItems, shippingFee: $shippingFee, type: $type, step: $step, status: $status, packageStatus: $packageStatus, declaredTotal: $declaredTotal, trackingCode: $trackingCode, paymentVoucher: $paymentVoucher, updateAt: $updateAt, createdAt: $createdAt, lastPackageUpdateLocation: $lastPackageUpdateLocation)';
  }
}
