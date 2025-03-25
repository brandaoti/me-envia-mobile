import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class BoxModalLimit {
  final BuildContext context;
  final VoidCallback? onClosing;

  const BoxModalLimit({
    this.onClosing,
    required this.context,
  });

  void show() {
    showModalBottomSheet(
      context: context,
      builder: _builder,
      shape: Decorations.dialogs,
    );
  }

  void _close() {
    Navigator.of(context).pop();
    onClosing?.call();
  }

  Widget _builder(BuildContext context) {
    return SafeArea(
      child: Container(
        child: _body(),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VerticalSpacing(18),
          _title(),
          const VerticalSpacing(40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _icon(),
              const HorizontalSpacing(24),
              Expanded(
                child: _notificationText(),
              ),
            ],
          ),
          const VerticalSpacing(40),
          _confirmBtn(),
          const VerticalSpacing(16),
        ],
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.boxModalLimitTitle,
      style: TextStyles.boxModalLimitTitle,
    );
  }

  Widget _notificationText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _notificationTitle(),
        const VerticalSpacing(8),
        ...Strings.boxModalLimitNotificationSubtitle
            .map((info) => _notificationSubtitle(info))
            .toList(),
      ],
    );
  }

  Widget _icon() {
    return Container(
      height: Dimens.cardSendBoxHeight,
      width: Dimens.cardSendBoxHeight,
      decoration: BoxDecoration(
        color: AppColors.alertRedColor.withOpacity(.2),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          IconsData.iconMaxweightAllowed,
          size: 32,
          color: AppColors.alertRedColor,
        ),
      ),
    );
  }

  Widget _notificationTitle() {
    return AutoSizeText(
      Strings.boxModalLimitNotificationTitle,
      style: TextStyles.boxModalLimitNotificationTitle,
      textAlign: TextAlign.start,
    );
  }

  Widget _notificationSubtitle(String info) {
    return AutoSizeText(
      info,
      style: TextStyles.boxModalLimitNotificationSub,
      textAlign: TextAlign.start,
    );
  }

  Widget _confirmBtn() {
    return DefaultButton(
      title: Strings.boxModalLimitNotificationBtn,
      isValid: true,
      onPressed: _close,
    );
  }
}
