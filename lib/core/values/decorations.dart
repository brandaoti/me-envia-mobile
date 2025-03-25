import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class Decorations {
  static final inputBorderForms = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.secondary),
  );

  static final inputBorderFormFocused = inputBorderForms.copyWith(
    borderSide: const BorderSide(color: AppColors.black),
  );

  static BoxDecoration stepsDecoration(
    bool isActive, {
    Color primary = AppColors.primary,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: isActive ? primary : AppColors.grey300,
    );
  }

  static final RoundedRectangleBorder cardEditShapeBorder =
      RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: const BorderSide(width: 1, color: AppColors.grey300),
  );

  static const RoundedRectangleBorder dropShipping = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  );

  // Tab Bar
  static const BoxDecoration tabBarWidget = BoxDecoration(
    color: AppColors.whiteDefault,
    boxShadow: [
      BoxShadow(
        offset: Offset(0, -8),
        blurRadius: 30,
        color: Color.fromRGBO(0, 0, 0, 0.1),
      )
    ],
  );

  static const BoxDecoration tabBarSteps = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    ),
  );

  static const RoundedRectangleBorder dialogs = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  );

//Maria Tips
  static BoxDecoration cardTipsDecoration({bool useBlur = false}) =>
      BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        gradient: useBlur
            ? LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  AppColors.grey400.withOpacity(0),
                  AppColors.secondary.withOpacity(0.8),
                ],
                end: Alignment.bottomCenter,
              )
            : null,
      );

  static const Decoration orderHeaderTabBar = UnderlineTabIndicator(
    borderSide: BorderSide(width: 8, color: AppColors.primary),
  );

  static BoxDecoration cardOrderItem(bool isSelected) => BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 13,
            offset: Offset(0, 4),
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        ],
        border: isSelected
            ? Border.all(color: AppColors.alertGreenColor, width: 2)
            : null,
      );

  static BoxDecoration sendBoxCard = BoxDecoration(
    color: AppColors.transparent,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        blurRadius: 13,
        offset: Offset(0, 4),
        color: Color.fromRGBO(0, 0, 0, 0.05),
      ),
    ],
  );

  static final BoxDecoration boxCarRequestedBox = BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.secondary.withOpacity(.05),
  );
}
