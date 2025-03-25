import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

typedef IconState = Map<bool, Map<String, Object>>;

class ModalCreateBoxConfirmation {
  final bool isDropShipping;
  final BuildContext context;
  final ValueChanged<bool> onConfirm;
  final VoidCallback? onEnterInContact;

  const ModalCreateBoxConfirmation({
    this.onEnterInContact,
    required this.context,
    required this.onConfirm,
    this.isDropShipping = true,
  });

  void show() {
    showModalBottomSheet(
      context: context,
      builder: _builder,
      shape: Decorations.dropShipping,
      isDismissible: isDropShipping ? true : false,
      isScrollControlled: isDropShipping ? true : false,
    );
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
        VerticalSpacing(isDropShipping ? 100 : 24),
        _icon(),
        VerticalSpacing(isDropShipping ? 36 : 24),
        _title(),
        const VerticalSpacing(16),
        _subtitle(),
        VerticalSpacing(isDropShipping ? 56 : 24),
        _actions(),
      ],
    );
  }

  Widget _icon() {
    const IconState mappingState = {
      true: {
        'color': AppColors.primary,
        'size': Dimens.dialogIcon,
        'icon': Svgs.iconDropShipping,
      },
      false: {
        'size': 80.0,
        'icon': Svgs.iconWhatsApp,
        'color': AppColors.whatsAppColor,
      },
    };

    final state = mappingState[isDropShipping]!;
    final size = state['size'] as double;
    final color = state['color'] as Color;

    return Container(
      width: Dimens.dialogIcon,
      height: Dimens.dialogIcon,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDropShipping ? color.withOpacity(0.2) : color,
      ),
      padding: Paddings.copyButton,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        state['icon'] as String,
        width: size,
        height: size,
        color: isDropShipping ? color : null,
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      isDropShipping ? Strings.dropShipping : Strings.enterInContact,
      style: TextStyles.modalConfirmOrderTitleStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      isDropShipping
          ? Strings.dropShippingMessage
          : Strings.enterInContactMessage,
      textAlign: TextAlign.center,
      style: TextStyles.modalConfirmOrderSubtitleStyle,
    );
  }

  Widget _actions() {
    return Visibility(
      visible: isDropShipping,
      replacement: _enterToContact(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _confirmBtn(),
          const VerticalSpacing(24),
          _editBoxBtn(),
          const VerticalSpacing(36),
        ],
      ),
    );
  }

  void _close(bool value) {
    Navigator.of(context).pop();
    onConfirm(value);
  }

  Widget _enterToContact() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: DefaultButton(
        isValid: true,
        title: Strings.enterInContactTitleButton,
        onPressed: () {
          _close(false);
          onEnterInContact?.call();
        },
      ),
    );
  }

  Widget _confirmBtn() {
    return DefaultButton(
      isValid: true,
      onPressed: () => _close(false),
      title: Strings.dropShippingButtons.first,
    );
  }

  Widget _editBoxBtn() {
    return BordLessButton(
      isValid: true,
      onPressed: () => _close(true),
      title: Strings.dropShippingButtons.last,
    );
  }
}
