import 'package:flutter/material.dart';

import 'dimens.dart';

abstract class Paddings {
  static const horizontal = EdgeInsets.symmetric(
    horizontal: Dimens.horizontal,
  );

  static const vertical = EdgeInsets.symmetric(
    vertical: Dimens.horizontal,
  );

  static const verticalTop = EdgeInsets.only(
    top: Dimens.horizontal,
  );

  //Inputs
  static const inputPaddingForms = EdgeInsets.symmetric(
    vertical: Dimens.vertical,
  );

  static const inputContentPadding =
      EdgeInsets.symmetric(vertical: 18, horizontal: Dimens.vertical);

  static const listTilePadding = EdgeInsets.all(Dimens.vertical);
  static const sendBoxExpanded = EdgeInsets.symmetric(
    horizontal: 8,
    vertical: Dimens.vertical,
  );

  // Registration
  static const bodyHorizontal = EdgeInsets.symmetric(
    horizontal: Dimens.horizontal24,
  );

  // ExpansionCards
  static const expansiontion = listTilePadding;
  static const sendBoxCard = EdgeInsets.only(left: Dimens.vertical);
  static const expansiontionTitle = EdgeInsets.only(left: 8, top: 15);

  // Tab Bar
  static const tabBarItemsHorizontal = EdgeInsets.symmetric(horizontal: 12);

  static const mariaTipsCardPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 10,
  );

  static const declarationItems =
      EdgeInsets.only(top: Dimens.vertical, bottom: 40);

  static const zero = EdgeInsets.zero;
  static const copyButton = EdgeInsets.all(Dimens.vertical);

  // Who is Maria
  static const whoIsMariaBody =
      EdgeInsets.symmetric(horizontal: 20, vertical: 32);
}
