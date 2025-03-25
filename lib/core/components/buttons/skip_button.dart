import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../values/values.dart';

class SkipButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const SkipButton({
    Key? key,
    this.title = '',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _text(),
      onPressed: onPressed,
    );
  }

  Widget _text() {
    return AutoSizeText(
      title,
      style: TextStyles.skipButton,
    );
  }
}
