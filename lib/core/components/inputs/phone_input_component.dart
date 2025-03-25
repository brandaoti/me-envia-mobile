import 'package:flutter/material.dart';

import '../../core.dart';

class PhoneInputComponent extends StatelessWidget {
  final String? labelText;
  final EdgeInsets padding;
  final FormFields? formFields;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const PhoneInputComponent({
    Key? key,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    required this.formFields,
    this.padding = Paddings.inputPaddingForms,
    this.labelText = Strings.phoneInputLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        focusNode: formFields?.focus,
        style: TextStyles.inputTextStyle,
        keyboardType: TextInputType.phone,
        controller: formFields?.controller,
        textInputAction: TextInputAction.go,
        validator: validator ?? Validators.phone,
        decoration: InputDecoration(
          labelText: labelText,
          border: Decorations.inputBorderForms,
          contentPadding: Paddings.inputContentPadding,
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
