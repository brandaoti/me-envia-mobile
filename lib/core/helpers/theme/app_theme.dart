// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../values/values.dart';

abstract class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      fontFamily: 'Lato',
      appBarTheme: _appBarTheme(),
      primaryColor: AppColors.primary,
      accentColor: AppColors.secondary,
      primaryColorDark: AppColors.primary,
      errorColor: AppColors.alertRedColor,
      textSelectionTheme: _textSelectionTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      scaffoldBackgroundColor: AppColors.whiteDefault,
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColors.primary,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static AppBarTheme _appBarTheme() {
    return const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.whiteDefault,
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      hoverColor: AppColors.white,
      focusColor: AppColors.primary,
      labelStyle: TextStyles.labelStyle,
      border: Decorations.inputBorderForms,
      enabledBorder: Decorations.inputBorderForms,
      fillColor: AppColors.grey300.withOpacity(0.1),
      focusedBorder: Decorations.inputBorderFormFocused,
      disabledBorder: Decorations.inputBorderFormFocused,
    );
  }

  static TextSelectionThemeData _textSelectionTheme() {
    return const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.grey300,
    );
  }

  static void setLightStatusBar() {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    }
  }

  static void setDarkStatusBar() {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }
}
