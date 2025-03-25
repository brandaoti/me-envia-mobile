import 'package:flutter/material.dart';

import 'values.dart';

abstract class Sizes {
  static const Size orderHeaderStandardHeight = Size.fromHeight(
    Dimens.orderHeaderStandardHeight,
  );

  static const BoxConstraints dollarConstraints = BoxConstraints(
    maxHeight: 28,
    minWidth: 100,
  );

  static const BoxConstraints paymentpackageList = BoxConstraints(
    maxWidth: 160,
  );
}
