import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../components.dart';

class ActionToErrorState {
  final String helper;
  final String? message;
  final String? buttonText;
  final BuildContext context;
  final VoidCallback? onConfirm;

  const ActionToErrorState({
    this.message,
    this.onConfirm,
    required this.context,
    this.buttonText = Strings.changeData,
    this.helper = Strings.errorRegistrationFailure,
  });

  void show() {
    showModalBottomSheet(
      context: context,
      builder: _builder,
      isDismissible: false,
      shape: Decorations.dialogs,
      barrierColor: AppColors.black.withOpacity(0.2),
    );
  }

  Widget _builder(BuildContext context) {
    return SafeArea(
      child: Container(
        child: _body(),
        width: double.infinity,
        padding: Paddings.bodyHorizontal,
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _warningIcon(),
        _message(),
        _confirmButon(),
      ],
    );
  }

  Widget _warningIcon() {
    const size = Dimens.dialogIllustration;

    return Padding(
      padding: const EdgeInsets.only(top: 38, bottom: 18),
      child: SvgPicture.asset(Svgs.warningYellow, height: size, width: size),
    );
  }

  Widget _message() {
    return Column(
      children: [
        AutoSizeText(
          message ?? '',
          textAlign: TextAlign.center,
          style: TextStyles.resgitrationAccepTermOfUse.copyWith(
            fontSize: 22,
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const VerticalSpacing(16),
        AutoSizeText(
          helper,
          textAlign: TextAlign.center,
          style: TextStyles.resgitrationAccepTermOfUse.copyWith(
            height: 1.6,
            fontSize: 18,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _onConfirm() {
    _close();
    onConfirm?.call();
  }

  Widget _confirmButon() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: DefaultButton(
        isValid: true,
        onPressed: _onConfirm,
        title: buttonText ?? '',
      ),
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }
}
