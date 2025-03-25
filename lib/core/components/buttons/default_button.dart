import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../components.dart';

class DefaultButton extends StatelessWidget {
  final String? title;
  final bool isValid;
  final bool isLoading;
  final double radius;
  final Color background;
  final VoidCallback? onPressed;

  final double? fontSize;
  final EdgeInsets? paddings;
  final FontWeight? fontWeight;

  const DefaultButton({
    Key? key,
    this.title = '',
    this.isValid = false,
    this.isLoading = false,
    this.radius = 4.0,
    this.onPressed,
    this.fontSize,
    this.fontWeight,
    this.paddings = Paddings.zero,
    this.background = AppColors.disabledButtonOffsetColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.buttonHeight,
      child: ElevatedButton(
        child: _child(),
        style: getStyle(),
        onPressed: isValid ? onPressed : null,
      ),
    );
  }

  ButtonStyle getStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        isValid ? AppColors.primary : background,
      ),
      padding: MaterialStateProperty.all(paddings),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _child() {
    return Visibility(
      visible: isLoading,
      child: _isLoading(),
      replacement: _text(),
    );
  }

  Widget _isLoading() {
    return const SizedBox(
      width: 30,
      height: 30,
      child: Loading(
        color: AppColors.white,
      ),
    );
  }

  Widget _text() {
    return AutoSizeText(
      title ?? '',
      style: TextStyles.defaultButton(isValid).copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
