import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/components/components.dart';
import '../../../../core/types/types.dart';
import '../../../../core/values/values.dart';

class NoOrderItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final EdgeInsets padding;
  final String? buttonText;
  final String illustration;
  final double illustrationSize;
  final VoidCallback? onPressed;
  final bool useReviewTutorialButton;

  const NoOrderItemWidget({
    Key? key,
    this.buttonText,
    this.onPressed,
    this.title = Strings.noStockItem,
    this.padding = Paddings.bodyHorizontal,
    this.illustration = Svgs.noOrderItemSvg,
    this.subtitle = Strings.noOrderItemText,
    this.illustrationSize = Dimens.imageSize250Px,
    this.useReviewTutorialButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _illustration(),
          const VerticalSpacing(50),
          _texts(),
          const VerticalSpacing(24),
          _buttons(),
        ],
      ),
    );
  }

  Widget _illustration() {
    return SvgPicture.asset(
      illustration,
      width: illustrationSize,
      height: illustrationSize,
    );
  }

  Widget _texts() {
    return Column(
      children: [
        _title(),
        const VerticalSpacing(16),
        _subtitle(),
      ],
    );
  }

  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.noOrderItemTitleStyle,
      ),
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyles.noOrderItemSubtitleStyle,
    );
  }

  void _navigateToAddressScrteen() {
    Modular.to.pushNamed(
      RoutesName.addressInformation.linkNavigate,
    );
  }

  Widget _buttons() {
    return Column(
      children: [
        DefaultButton(
          isValid: true,
          onPressed: onPressed ?? _navigateToAddressScrteen,
          title: buttonText ?? Strings.noOrderItemButtonText.first,
        ),
        const VerticalSpacing(16),
        Visibility(
          visible: useReviewTutorialButton,
          child: BordLessButton(
            isValid: true,
            title: Strings.noOrderItemButtonText[1],
            onPressed: () => Modular.to.pushNamed(RoutesName.tutorial.name),
          ),
        ),
      ],
    );
  }
}
