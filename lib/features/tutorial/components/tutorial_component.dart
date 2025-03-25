import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';
import '../tutorial.dart';

class TutorialComponent extends StatelessWidget {
  final TutorialItem tutorialItem;

  const TutorialComponent({
    Key? key,
    required this.tutorialItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Center(child: _illustrations()),
        ),
        _body(),
      ],
    );
  }

  Widget _illustrations() {
    return AnimatedSwitcher(
      duration: Durations.transition,
      child: tutorialItem.iconPath == null ? _svgPicture() : _iconPicture(),
    );
  }

  Widget _svgPicture() {
    return SvgPicture.asset(
      tutorialItem.svgPath!,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      width: Dimens.imageSize250Px,
      height: Dimens.imageSize250Px,
    );
  }

  Widget _iconPicture() {
    return Image.asset(
      tutorialItem.iconPath!,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      width: Dimens.imageSize250Px,
      height: Dimens.imageSize250Px,
    );
  }

  Widget _body() {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VerticalSpacing(16.0),
          _title(),
          const VerticalSpacing(16.0),
          Visibility(
            visible: tutorialItem.isBigText,
            child: Expanded(
              child: _subtitle(),
            ),
            replacement: _subtitle(),
          ),
          _message(),
        ],
      ),
    );
  }

  Widget _title() {
    return FittedBox(
      child: AutoSizeText(
        tutorialItem.title,
        style: TextStyles.tutorialTitle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _subtitle() {
    final tutorialTypes = tutorialItem.listTypes;

    return AutoSizeText.rich(
      TextSpan(
        text: tutorialTypes.first.title,
        children: tutorialTypes.map(_textSpan).toList(),
        style: TextStyles.tutorialSubtitle,
      ),
      minFontSize: 12,
      textAlign: TextAlign.center,
    );
  }

  TextSpan _textSpan(TutorialStringTypes types) {
    return TextSpan(
      text: types.subtitle,
      style: TextStyles.tutorialSubtitle.copyWith(
        fontWeight: types.isTextBold ? FontWeight.w900 : null,
      ),
    );
  }

  Widget _message() {
    if (tutorialItem.message == null) {
      return Container();
    }

    return AutoSizeText(
      tutorialItem.message,
      textAlign: TextAlign.center,
      style: TextStyles.tutorialSubTitle2,
    );
  }
}
