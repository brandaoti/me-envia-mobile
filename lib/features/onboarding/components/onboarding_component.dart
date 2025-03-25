import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';
import '../model/onboarding_item.dart';

class OnBoardingComponent extends StatelessWidget {
  final OnBoardingItem onBoardingItem;

  const OnBoardingComponent({
    Key? key,
    required this.onBoardingItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpacing(24.0),
        Expanded(
          flex: 2,
          child: _svgPicture(),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpacing(24.0),
              _title(),
              const VerticalSpacing(24.0),
              Expanded(
                child: _subtitle(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _svgPicture() {
    return SvgPicture.asset(
      onBoardingItem.assetName,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      width: Dimens.onboardingAssetSize,
      height: Dimens.onboardingAssetSize,
    );
  }

  Widget _title() {
    return AutoSizeText(
      onBoardingItem.title,
      textAlign: TextAlign.center,
      style: TextStyles.onboardingTitle,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      onBoardingItem.subtitle,
      textAlign: TextAlign.center,
      style: TextStyles.onbardingSubtitle,
    );
  }
}
