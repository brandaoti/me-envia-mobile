import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ModalConfirmOrder {
  final BuildContext context;
  final bool hasItemSelected;
  final VoidCallback onConfirm;
  final VoidCallback onClosing;

  const ModalConfirmOrder({
    required this.context,
    required this.onConfirm,
    required this.onClosing,
    required this.hasItemSelected,
  });

  void show() {
    showModalBottomSheet(
      context: context,
      builder: _builder,
      enableDrag: false,
      isScrollControlled: true,
      shape: Decorations.dialogs,
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }

  Widget _builder(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: Paddings.bodyHorizontal,
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const VerticalSpacing(100),
        _icon(),
        const VerticalSpacing(36),
        _title(),
        const VerticalSpacing(16),
        _subtitle(),
        const VerticalSpacing(56),
        _confirmBtn(),
        const VerticalSpacing(24),
        _editBoxBtn(),
        const VerticalSpacing(36),
      ],
    );
  }

  Widget _icon() {
    return Container(
      width: Dimens.dialogIcon,
      height: Dimens.dialogIcon,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(.2),
      ),
      child: const Icon(
        IconsData.iconWarningRounded,
        color: AppColors.primary,
        size: 112,
      ),
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.modalConfirmOrderBoxTitle,
      style: TextStyles.modalConfirmOrderTitleStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      hasItemSelected
          ? Strings.modalConfirmOrderBoxSubtitle
          : Strings.modalConfirmOrderBoxErro,
      textAlign: TextAlign.center,
      style: TextStyles.modalConfirmOrderSubtitleStyle,
    );
  }

  void _onConfirm() {
    _close();
    onConfirm();
  }

  Widget _confirmBtn() {
    return DefaultButton(
      isValid: true,
      onPressed: hasItemSelected ? _onConfirm : _close,
      title: hasItemSelected ? Strings.modalConfirmOrderBtn : Strings.ok,
    );
  }

  Widget _editBoxBtn() {
    return Visibility(
      visible: hasItemSelected,
      child: BordLessButton(
        isValid: true,
        onPressed: () {
          _close();
          onClosing.call();
        },
        title: Strings.modalEditBoxBtn,
      ),
    );
  }
}
