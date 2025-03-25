import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

import 'card_itens_notification.dart';

class TutorialModalTaxationWarning {
  final BuildContext context;
  final VoidCallback? onClosing;

  const TutorialModalTaxationWarning({
    required this.context,
    required this.onClosing,
  });

  void show() {
    showModalBottomSheet(
      context: context,
      builder: _builder,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: Decorations.dropShipping,
    );
  }

  void _close() {
    Navigator.of(context).pop();
    onClosing?.call();
  }

  Widget _builder(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: context.screenHeight - 120,
        child: SingleChildScrollView(
          child: _body(),
          padding: Paddings.horizontal,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const VerticalSpacing(34),
        _logo(),
        const VerticalSpacing(24),
        _title(),
        _deliverySteps(),
        _subtitle(),
        const VerticalSpacing(24),
        _notificationWarning(),
        const VerticalSpacing(24),
        _defaultButton(),
        const VerticalSpacing(24),
      ],
    );
  }

  Widget _logo() {
    return Image.asset(
      Images.tutorialLogoWarning,
      fit: BoxFit.cover,
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.modalTaxationWarningTitleText[0],
      style: TextStyles.tutorialModalTitle,
      textAlign: TextAlign.center,
    );
  }

  Widget _deliverySteps() {
    return const DeliverySteps(
      type: PackageType.warning,
      steps: PackageStep.arrivedInbrazil,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      Strings.modalTaxationWarningSubtitleText[0],
      style: TextStyles.tutorialModalSubtitle,
      textAlign: TextAlign.center,
    );
  }

  Widget _notificationWarning() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardItensNotificationComponent(
          icon: IconsData.iconAccountBalanceWallet,
          iconColor: AppColors.alertYellowColor,
          title: Strings.modalTaxationWarningTitleText[1],
          subtitle: Strings.modalTaxationWarningSubtitleText[1],
        ),
        CardItensNotificationComponent(
          icon: IconsData.iconDoubleArrow,
          title: Strings.modalTaxationWarningTitleText[2],
          subtitle: Strings.modalTaxationWarningSubtitleText[2],
        ),
      ],
    );
  }

  Widget _defaultButton() {
    return DefaultButton(
      isValid: true,
      onPressed: _close,
      title: Strings.tutorialModalServiceFeesBtn,
    );
  }
}
