import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class BordLessButton extends StatelessWidget {
  final String? title;
  final bool isValid;
  final bool isLoading;
  final VoidCallback? onPressed;

  const BordLessButton({
    Key? key,
    this.title = '',
    this.isValid = true,
    this.onPressed,
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
      overlayColor: MaterialStateProperty.all<Color>(AppColors.white),
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.transparent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(width: 2.0, color: Colors.transparent),
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
    return const AutoSizeText(
      Strings.loadingButtonText,
      style: TextStyle(fontSize: 18, color: AppColors.grey200),
    );
  }

  Widget _text() {
    return AutoSizeText(
      title ?? '',
      style: TextStyles.bordlessButton(isValid),
    );
  }
}
