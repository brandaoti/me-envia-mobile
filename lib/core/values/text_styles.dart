import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class TextStyles {
  static const TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
    color: AppColors.grey500,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle inputTextStyle = labelStyle.copyWith(
    color: AppColors.black,
  );

//onBoarding TextStyles
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle onbardingSubtitle = TextStyle(
    height: 1.4,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle onboardinglastString = TextStyle(
    fontSize: 18,
    color: AppColors.grey500,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get mantraStyleTitle => const TextStyle(
        color: AppColors.primary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get mantraStyleMessage => const TextStyle(
        fontSize: 18,
        color: AppColors.grey500,
        fontWeight: FontWeight.w400,
      );

// Buttons TextStyles
  static TextStyle defaultButton(bool isValid) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: isValid ? AppColors.white : AppColors.grey400,
      );

  static TextStyle bordlessButton(bool isValid) => TextStyle(
        color: isValid ? AppColors.primary : AppColors.grey400,
        fontSize: 18,
      );

  static TextStyle roundedButton(bool isValid) => TextStyle(
        color: isValid ? AppColors.primary : AppColors.grey400,
        fontSize: 18,
      );

  static const TextStyle skipButton = TextStyle(
    color: AppColors.grey500,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  //forgotPassWord TextStyles
  static const TextStyle forgotPasswordTitles = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal,
    color: AppColors.black,
  );

  static const TextStyle forgotPasswordContent = TextStyle(
    fontSize: 21.0,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // Edit Profile TextStyles
  static const TextStyle bodyEditingProfileStyle = TextStyle(
    fontSize: 38,
    color: AppColors.secondary,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle sectionProfileFirstStyle = TextStyle(
    color: AppColors.black,
    fontSize: 28,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle sectionProfileSecondStyle = TextStyle(
    color: AppColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle cardEditPersonalTitle = TextStyle(
    color: AppColors.secondary,
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );

  // TabBar
  static TextStyle tabBarItemText(bool isActive) => TextStyle(
        fontSize: 12,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w400,
        color: isActive ? AppColors.secondary : AppColors.grey400,
      );

  static const TextStyle expansionTileContentStyle = TextStyle(
    height: 1.45,
    fontSize: 16,
    color: AppColors.secondary,
    fontWeight: FontWeight.w500,
  );

  // who is maria
  static const TextStyle whoIsMariaContentStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // Registration
  static const TextStyle registrationTitleStyle = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    color: AppColors.secondary,
  );

  //Tutorial TextStyles
  static const TextStyle tutorialTitle = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle tutorialSubtitle = TextStyle(
    height: 1.2,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle tutorialSubTitle2 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w900,
  );

  // Tutorial modal TextStyles
  static const TextStyle rateAndDescriptionTitle = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle rateSubtitle = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  static const TextStyle tutorialModalTitle = TextStyle(
    height: 1.4,
    fontSize: 28,
    color: AppColors.black,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle tutorialModalSubtitle = TextStyle(
    height: 1.4,
    fontSize: 16,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  //learn More
  static const TextStyle whoIsMariaSubtitle = TextStyle(
    fontSize: 20,
    color: AppColors.secondary,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle learnMoreTitleStyle = TextStyle(
    fontSize: 38,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  //Maria tips
  static const TextStyle mariaTipsTitle = TextStyle(
    height: 1.4,
    fontSize: 38,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static final TextStyle mariaTipsCardDate = mariaTipsTitle.copyWith(
    fontSize: 12,
    color: AppColors.grey500,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle mariaTipsCardDescription = TextStyle(
    fontSize: 16,
    height: 1.3,
  );

  static const TextStyle mariaTipsDetailsDescription = TextStyle(
    fontSize: 18,
    height: 1.4,
  );

  //faq
  static const TextStyle faqSubtitleStyle = TextStyle(
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.w500,
  );

  // Cards
  static const TextStyle cardModalItemTitle = TextStyle(
    height: 1.5,
    fontSize: 24,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle cardModalItemSubtitle = TextStyle(
    fontSize: 12,
    height: 1.4,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  // Order Items and Address out of stock
  static const TextStyle noOrderItemTitleStyle = TextStyle(
    color: AppColors.black,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    height: 1.2,
  );
  static const TextStyle noOrderItemSubtitleStyle = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle stockAddressTitleStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    height: 1.2,
  );

  static const TextStyle cardStockAddressTitle = TextStyle(
    height: 1.5,
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle cardStockAddressSubtitle = TextStyle(
    height: 1.5,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryLightText,
  );
  static const TextStyle copyAddress = TextStyle(
    height: 1.5,
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle recipientAddressInformation =
      stockAddressTitleStyle.copyWith(
    fontWeight: FontWeight.w800,
  );

  // Resgitration
  static const TextStyle resgitrationHeaderTitle = TextStyle(
    fontSize: 38,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle resgitrationTermOfUseTitle = TextStyle(
    height: 1.6,
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle resgitrationAccepTermOfUse = TextStyle(
    fontSize: 14,
    color: AppColors.secondary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle termOfUseDocs = TextStyle(
    height: 1.6,
    fontSize: 12,
    color: AppColors.black,
    fontWeight: FontWeight.normal,
  );

  //No Connection
  static const TextStyle noConnectionTitle = TextStyle(
    color: AppColors.black,
    height: 1.4,
    fontSize: 28,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle noConnectionSubtitle = TextStyle(
    color: AppColors.black,
    height: 1.4,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // Home
  static const TextStyle headerMoreTips = TextStyle(
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle headerDollar = TextStyle(
    fontSize: 14,
    color: AppColors.alertGreenColor,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle noTipsTitleStyle = TextStyle(
    color: AppColors.whiteDefault,
    fontSize: 21,
    fontWeight: FontWeight.w900,
    height: 1.2,
  );

  // ! Box Illustration
  static const TextStyle objectNotificationStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle textLocationStyle = TextStyle(
    height: 1.5,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryLightText,
  );
  static const TextStyle boxTitleStyle = TextStyle(
    height: 1.3,
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle boxCountStyle = TextStyle(
    fontSize: 12,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle toMonthAbbreStrStyle = TextStyle(
    fontSize: 12,
    color: AppColors.secondary,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle toHourAbbreStrStyle = TextStyle(
    fontSize: 12,
    color: AppColors.grey400,
    fontWeight: FontWeight.w400,
  );

  // Order Screen
  static const TextStyle orderHeaderTabBar = TextStyle(
    fontSize: 18,
    color: AppColors.whiteText,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle orderHeaderPhotoAttached = TextStyle(
    fontSize: 14,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle orderBoxProduct = orderHeaderPhotoAttached.copyWith(
    height: 1.4,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  // Box Bottom Sheet and Confirm order
  static final TextStyle boxModalLimitTitle = stockAddressTitleStyle.copyWith(
    fontWeight: FontWeight.w800,
  );

  static final TextStyle boxModalLimitNotificationTitle =
      cardModalItemTitle.copyWith(
    fontWeight: FontWeight.w800,
    color: AppColors.secondary,
  );

  static final TextStyle boxModalLimitNotificationSub =
      cardModalItemSubtitle.copyWith(
    height: 1.5,
    color: AppColors.secondary,
  );

  //Requested box
  static const TextStyle declarationValue = TextStyle(
    fontSize: 12,
    color: AppColors.primary,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle modalConfirmOrderTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.secondary,
  );
  static const TextStyle modalConfirmOrderSubtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  // Customs Declaration
  static const TextStyle customsDeclarationStyle = noConnectionTitle;
  static const TextStyle cardDeclarationItemTitle = TextStyle(
    height: 1.6,
    fontSize: 18,
    color: AppColors.secondary,
    fontWeight: FontWeight.w800,
  );
  static final TextStyle cardDeclarationItemSubtitle =
      cardDeclarationItemTitle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryLightText,
  );
}
