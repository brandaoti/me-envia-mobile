import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core.dart';

class Done extends StatelessWidget {
  final String src;
  final String title;
  final double heigth;
  final String subtitle;
  final Color textColor;

  const Done({
    Key? key,
    this.heigth = 280,
    this.src = Svgs.onBoarding3,
    this.textColor = AppColors.black,
    this.title = Strings.paymentCreated,
    this.subtitle = Strings.paymentCreatedMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _illustration(),
        const VerticalSpacing(64),
        _title(),
        const VerticalSpacing(16),
        _subtitle()
      ],
    );
  }

  Widget _illustration() {
    return Center(
      child: SvgPicture.asset(
        src,
        width: heigth,
        height: heigth,
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      title,
      minFontSize: 24,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationHeaderTitle.copyWith(
        fontSize: 28,
        color: textColor,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      subtitle,
      minFontSize: 18,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationHeaderTitle.copyWith(
        fontSize: 21,
        color: textColor,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
