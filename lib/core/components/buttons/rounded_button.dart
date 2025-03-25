import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../components.dart';

class RoundedButton extends StatelessWidget {
  final String? title;
  final bool isValid;
  final bool isLoading;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const RoundedButton({
    Key? key,
    this.padding,
    this.onPressed,
    this.textStyle,
    this.title = '',
    this.isValid = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.buttonHeight,
      child: TextButton(
        child: _child(),
        style: getButtonStyle(),
        onPressed: isValid ? onPressed : null,
      ),
    );
  }

  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        isValid ? Colors.transparent : AppColors.disabledButtonOffsetColor,
      ),
      padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            width: 2.0,
            color: isValid ? AppColors.primary : AppColors.grey200,
          ),
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
      width: 18,
      height: 18,
      child: Loading(
        color: AppColors.primary,
      ),
    );
  }

  Widget _text() {
    return Text(
      title ?? '',
      style: textStyle ?? TextStyles.roundedButton(isValid),
    );
  }
}
