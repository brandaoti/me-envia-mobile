import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/components/components.dart';
import '../../../core/values/values.dart';

class TutorialInitial extends StatelessWidget {
  final VoidCallback? onJumpTutorial;
  final VoidCallback? onStartTutorial;

  const TutorialInitial({
    Key? key,
    required this.onJumpTutorial,
    required this.onStartTutorial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _illustration(),
        const VerticalSpacing(60),
        _title(),
        const VerticalSpacing(32),
        _onFinishTutorialButton(),
        const VerticalSpacing(16),
        _skipTutorialButton()
      ],
    );
  }

  Widget _illustration() {
    return SvgPicture.asset(
      Svgs.tutorial,
      width: Dimens.imageSize280Px,
      height: Dimens.imageSize280Px,
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.tutorialTitleFirstText,
      style: TextStyles.forgotPasswordTitles.copyWith(
        fontSize: 26,
      ),
    );
  }

  Widget _onFinishTutorialButton() {
    return DefaultButton(
      radius: 8,
      isValid: true,
      onPressed: onStartTutorial,
      title: Strings.tutorialStart,
    );
  }

  Widget _skipTutorialButton() {
    return BordLessButton(
      onPressed: onJumpTutorial,
      title: Strings.skipTutorial,
    );
  }
}
