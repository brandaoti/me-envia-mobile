import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

import '../../../core/core.dart';

class TabBarItem extends StatelessWidget {
  final String text;
  final String? icon;
  final bool isActive;
  final bool useAppLogo;
  final bool isCreatingABox;
  final VoidCallback? onPressed;
  final CardController controller;

  const TabBarItem({
    Key? key,
    required this.text,
    this.icon,
    required this.isActive,
    this.useAppLogo = false,
    required this.onPressed,
    required this.controller,
    this.isCreatingABox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: _body(),
        alignment: Alignment.center,
        width: Dimens.tabBarItemsSize,
        padding: const EdgeInsets.only(top: 4),
      ),
      onTap: onPressed,
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          child: _logoBox(),
          visible: useAppLogo,
          replacement: _icon(),
        ),
        const VerticalSpacing(8),
        AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: TextStyles.tabBarItemText(isActive),
        ),
        const VerticalSpacing(8),
      ],
    );
  }

  Widget _icon() {
    if ((icon ?? '').isEmpty) {
      return const SizedBox(
        width: 32,
        height: 32,
      );
    }

    return SvgPicture.asset(
      icon!,
      color: isActive ? null : AppColors.grey400,
    );
  }

  Widget _logoBox() {
    return StreamBuilder<BoxList>(
      stream: controller.cardList,
      builder: (context, snapshot) {
        final BoxList cardList = snapshot.data ?? [];
        return SizedBox(
          height: 36,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                top: -40,
                right: 0,
                child: _feedbackToCreateBox(
                  cardList: cardList,
                  child: _logo(cardList),
                ),
              ),
              Positioned(
                top: -26,
                right: 22,
                child: _countBoxItems(cardList.length),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _logo(BoxList cardList) {
    late final Color color;

    if (cardList.isEmpty) {
      color = AppColors.grey300;
    } else {
      color = AppColors.alertGreenColor;
    }

    return Container(
      alignment: Alignment.center,
      width: Dimens.tabBarStandardHeight,
      height: Dimens.tabBarStandardHeight,
      child: SvgPicture.asset(
        isCreatingABox ? Svgs.iconCreateBox : Svgs.logoTab,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCreatingABox ? color : AppColors.primaryLight,
      ),
    );
  }

  Widget _countBoxItems(int totalItems) {
    return Visibility(
      visible: isCreatingABox,
      child: Container(
        width: Dimens.horizontal,
        height: Dimens.horizontal,
        alignment: Alignment.center,
        child: AutoSizeText(
          totalItems.toString(),
          style: TextStyles.boxCountStyle,
        ),
        decoration: Decorations.boxCarRequestedBox.copyWith(
          color: AppColors.whiteDefault,
        ),
      ),
    );
  }

  Widget _feedbackToCreateBox({
    required Widget child,
    required BoxList cardList,
  }) {
    return StreamBuilder<FeedbackMessage>(
      initialData: const FeedbackMessage(),
      stream: controller.showFeedbackMessageStream,
      builder: (context, snapshot) {
        final feedback = snapshot.data!;

        return SimpleTooltip(
          child: child,
          hideOnTooltipTap: true,
          ballonPadding: Paddings.horizontal,
          borderColor: AppColors.transparent,
          animationDuration: Durations.transition,
          backgroundColor: feedback.backgroundColor,
          show: isCreatingABox && feedback.showFeedback,
          content: _feedbackToCreateBoxMessage(feedback),
        );
      },
    );
  }

  Widget _feedbackToCreateBoxMessage(FeedbackMessage feedback) {
    return Material(
      color: AppColors.transparent,
      child: AutoSizeText(
        feedback.message,
        style: TextStyles.resgitrationAccepTermOfUse.copyWith(
          color: AppColors.whiteDefault,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
