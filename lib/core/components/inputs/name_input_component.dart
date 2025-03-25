import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../values/values.dart';
import '../forms/forms.dart';

class NameInputComponent extends StatelessWidget {
  final String? labelText;
  final EdgeInsets padding;
  final FormFields? formFields;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const NameInputComponent({
    Key? key,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    required this.formFields,
    this.padding = Paddings.inputPaddingForms,
    this.labelText = Strings.nameInputLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        focusNode: formFields?.focus,
        style: TextStyles.inputTextStyle,
        keyboardType: TextInputType.text,
        controller: formFields?.controller,
        textInputAction: TextInputAction.go,
        validator: validator ?? Validators.name,
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
