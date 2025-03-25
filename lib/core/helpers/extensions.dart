import 'package:cubos_extensions/cubos_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../types/types.dart';
import '../values/values.dart';

extension ContextExtensions on BuildContext {
  /// Returns screen's height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns screen's width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns screen [Size], containing width and height
  Size get screenSize => MediaQuery.of(this).size;
}

extension DateTimeExtension on DateTime {
  String get toMonthAndDay {
    final month = toMonthStr;
    final day = this.day.toString().padLeft(2, '0');

    return '$day de $month';
  }

  String get toHourAbbreStr {
    final hour = this.hour.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');

    return '${hour}h$min';
  }

  String get toMonthAbbreStr {
    final month = this.month;
    final day = this.day.toString().padLeft(2, '0');

    return '$day ${Strings.brazilianMonthAbreviation[month] ?? ''}';
  }
}

extension StringExtension on String? {
  String get cleanMoney {
    if (this == null) return '';

    return this!.replaceAll('U\$', '').replaceAll(',', '.');
  }

  String get normalizePictureUrl {
    if (this != null) {
      final pictureNormalizedUrl = this!.replaceAll('file:///', '');
      return 'http://$pictureNormalizedUrl';
    }

    return '';
  }

  String get formatterCep {
    if (this == null) {
      return '';
    }

    if (this!.length < 8) {
      return this!;
    }

    final cep = this!.replaceAll('.', '').replaceAll('-', '').trim();

    final firstDigits = cep.substring(0, 2);
    final secondDigits = cep.substring(2, 5);
    final thirdDigits = cep.substring(5, 8);

    return '$firstDigits.$secondDigits-$thirdDigits';
  }
}

extension NumberExtension on num {
  String get formatterMoney {
    return NumberFormat.currency(
      symbol: 'U\$',
      locale: 'en_US',
    ).format(this);
  }

  String get formatterMoneyToBrasilian {
    return NumberFormat.currency(
      symbol: 'R\$',
      locale: 'pt_BR',
    ).format(this);
  }
}

extension CountryExtension on Country {
  bool get isBrazilianCountry {
    return name.compareTo(Strings.currentCountry) == 0;
  }

  bool findCountry(String actual) {
    return name.compareTo(actual) == 0;
  }
}

extension CountryListExtension on CountryList {
  Country? get fromBrazilianCountry {
    if (length > 1) {
      return firstWhere((it) => it.isBrazilianCountry);
    }

    return null;
  }

  Country? getCountryByName(String country) {
    if (length > 1) {
      return firstWhere((it) => it.findCountry(country));
    }

    return null;
  }

  void get sortByCountryName {
    if (length > 1) {
      return sort((a, b) => a.name.compareTo(b.name));
    }
  }
}

extension DeclarationListExtension on DeclarationList {
  double get amountToPay {
    if (length > 1) {
      return fold<double>(0, (a, b) => a + b.totalValue);
    }

    return first.totalValue;
  }
}

extension PackageExtension on Package {
  bool get hasPaymentPending {
    const mappingPayment = {
      PackageStatus.awaitingFee: true,
      PackageStatus.paymentRefused: true,
      PackageStatus.awaitingPayment: true,
      PackageStatus.paymentAccept: false,
      PackageStatus.paymentSubjectToConfirmation: false,
    };

    return mappingPayment[packageStatus] ?? true;
  }

  Map<String, dynamic> get boxIconAndColorStatus {
    if (type == null || step == null) {
      return {
        'isSvgIcon': true,
        'icon': Svgs.iconBox,
        'color': AppColors.alertGreenColor,
        'background': AppColors.alertGreenColorLight,
      };
    } else if (type == PackageType.success && step == PackageStep.delivered) {
      return {
        'isSvgIcon': false,
        'icon': Icons.check,
        'color': AppColors.alertGreenColor,
        'background': AppColors.alertGreenColorLight,
      };
    }

    late final Color color;
    late final Color background;

    if (type == PackageType.warning) {
      color = AppColors.alertYellowColor;
      background = AppColors.alertYellowColorLight;
    } else {
      color = AppColors.alertGreenColor;
      background = AppColors.alertGreenColorLight;
    }

    return {
      'color': color,
      'isSvgIcon': true,
      'icon': Svgs.iconBox,
      'background': background,
    };
  }
}

extension PackageListExtension on PackageList {
  void get sortByAmountToPay {
    if (length > 1) {
      return sort(
        (a, b) => a.paymentVoucher?.compareTo(b.paymentVoucher ?? '') ?? 0,
      );
    }
  }

  PackageList get sendBoxWithTrackingCode {
    return where((it) => it.trackingCode != null).toList();
  }
}

extension StatusHistoryExtension on StatusHistoryList {
  void get sortByStatusDate {
    if (length > 1) {
      sort((a, b) => b.statusDate.compareTo(a.statusDate));
    }
  }
}

extension DoubleListExtension on num {
  double toPrecision(int precision) {
    return double.parse((this).toStringAsFixed(precision));
  }

  int byCents() {
    return (this * 100).truncate();
  }

  double byRealToPrecision() {
    return (this / 100).toPrecision(2);
  }

  double byReal() {
    return (this / 100);
  }
}
