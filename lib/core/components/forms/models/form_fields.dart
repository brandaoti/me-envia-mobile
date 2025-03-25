import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormFields {
  final FocusNode? focus;
  final TextEditingController? controller;

  FormFields({
    FocusNode? focus,
    TextEditingController? controller,
  })  : focus = focus ?? FocusNode(),
        controller = controller ?? TextEditingController();

  factory FormFields.mask({String? mask}) {
    return FormFields(
      focus: FocusNode(),
      controller: MaskedTextController(mask: mask),
    );
  }

  String? get getText => controller?.value.text;

  void updateText(String? value) {
    controller?.text = value ?? '';
  }

  bool get isMaskedController =>
      controller != null && controller is MaskedTextController;

  void updateMask(String? value) {
    if (isMaskedController) {
      (controller as MaskedTextController).updateMask(value);
    }
  }

  void dispose() {
    focus?.dispose();
    controller?.dispose();
  }
}

class FormFieldsMoney extends FormFields {
  FormFieldsMoney({
    FocusNode? focus,
    MoneyMaskedTextController? controller,
  }) : super(
          focus: focus ?? FocusNode(),
          controller: controller ?? MoneyMaskedTextController(),
        );

  factory FormFieldsMoney.money({String? leftSymbol = 'U\$'}) {
    return FormFieldsMoney(
      focus: FocusNode(),
      controller: MoneyMaskedTextController(leftSymbol: leftSymbol),
    );
  }

  double get numberValue {
    return (controller as MoneyMaskedTextController).numberValue;
  }

  void updateValue(double value) {
    (controller as MoneyMaskedTextController).updateValue(value);
  }
}

class FormFieldFormatter extends FormFields {
  final MaskTextInputFormatter formatter;

  FormFieldFormatter({
    FocusNode? focus,
    TextEditingController? controller,
    required this.formatter,
  });

  factory FormFieldFormatter.mask({String? mask}) {
    return FormFieldFormatter(
      formatter: MaskTextInputFormatter(mask: mask),
    );
  }

  String? get getMaskValue => formatter.getMaskedText();
}
