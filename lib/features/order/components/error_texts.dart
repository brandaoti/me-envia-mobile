import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maria_me_envia/core/core.dart';

class ErrorText extends StatelessWidget {
  final String message;
  final double? height;
  final double imageSize;
  final String illustration;

  const ErrorText({
    Key? key,
    this.height = 260,
    this.message = Strings.noStockItem,
    this.imageSize = Dimens.imageSize230PX,
    this.illustration = Svgs.noOrderItemSvg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      height: height,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _body() {
    return Column(
      children: [
        _boxIllutrations(),
        const VerticalSpacing(12),
        _message(),
      ],
    );
  }

  Widget _boxIllutrations() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SvgPicture.asset(
        illustration,
        width: imageSize,
        height: imageSize,
      ),
    );
  }

  Widget _message() {
    return AutoSizeText(
      message,
      textAlign: TextAlign.center,
      style: TextStyles.orderBoxProduct.copyWith(
        height: 1.2,
        fontSize: 24,
      ),
    );
  }
}
