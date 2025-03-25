import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class CardCreateBox extends StatelessWidget {
  const CardCreateBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpacing(60),
        Align(
          alignment: Alignment.center,
          child: _illustration(),
        ),
        const VerticalSpacing(60),
        _title(),
        const VerticalSpacing(16),
        _subtitle(),
      ],
    );
  }

  Widget _illustration() {
    return SvgPicture.asset(
      Svgs.createBox,
      width: Dimens.imageSize250Px,
      height: Dimens.imageSize250Px,
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.createdBox,
      style: TextStyles.customsDeclarationStyle.copyWith(
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      Strings.createdBoxMessage,
      textAlign: TextAlign.center,
      style: TextStyles.cardDeclarationItemTitle.copyWith(
        height: 1.4,
        fontSize: 21,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
