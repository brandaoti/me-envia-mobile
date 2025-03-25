import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class TutorialModalServiceFees {
  final BuildContext context;
  final VoidCallback? onClosing;

  const TutorialModalServiceFees({
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpacing(50),
        _logo(),
        const VerticalSpacing(32),
        _modal(),
        const VerticalSpacing(20),
        _rateAndDescription(),
        const VerticalSpacing(30),
        _defaultButton(),
        const VerticalSpacing(30),
      ],
    );
  }

  Widget _logo() {
    return Image.asset(
      Images.tutorialLogoDollar,
      fit: BoxFit.cover,
    );
  }

  Widget _modal() {
    return Column(
      children: [
        _modalText(text: Strings.modalServiceFeesTexts[0]!),
        const VerticalSpacing(16),
        _modalText(
          text: Strings.modalServiceFeesTexts[1]!,
          style: TextStyles.tutorialModalSubtitle,
        ),
        const VerticalSpacing(32),
        _modalText(
          text: Strings.modalServiceFeesTexts[2]!,
          style: TextStyles.tutorialModalSubtitle,
        ),
      ],
    );
  }

  Widget _modalText({
    required String text,
    TextAlign textAlign = TextAlign.center,
    TextStyle style = TextStyles.tutorialModalTitle,
  }) {
    return AutoSizeText(
      text,
      style: style,
      textAlign: textAlign,
    );
  }

  Widget _rateAndDescription() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        color: AppColors.grey100,
        constraints: const BoxConstraints(minHeight: 170),
        child: Column(
          children: [
            _rateAndDescriptionHeader(),
            Column(
              children: Strings.modalRateSubtitleTexts.map((it) {
                return _rateAndDescriptionContent(
                  money: it['money']!,
                  message: it['message']!,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rateAndDescriptionHeader() {
    return Container(
      height: 60,
      color: AppColors.secondary,
      padding: Paddings.listTilePadding,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _modalText(
              text: Strings.modalRateAndDescriptionTitle.first,
              style: TextStyles.tutorialModalSubtitle.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const HorizontalSpacing(28),
          Expanded(
            flex: 6,
            child: _modalText(
              text: Strings.modalRateAndDescriptionTitle.last,
              textAlign: TextAlign.start,
              style: TextStyles.tutorialModalSubtitle.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rateAndDescriptionContent({
    required String money,
    required String message,
  }) {
    return Container(
      padding: Paddings.listTilePadding,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _modalText(
              text: money,
              style: TextStyles.tutorialModalSubtitle.copyWith(
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const HorizontalSpacing(28),
          Expanded(
            flex: 6,
            child: _modalText(
              text: message,
              textAlign: TextAlign.start,
              style: TextStyles.tutorialModalSubtitle.copyWith(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
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
