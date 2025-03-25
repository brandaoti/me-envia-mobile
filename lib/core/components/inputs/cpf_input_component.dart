import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../values/values.dart';
import '../forms/models/form_fields.dart';

class CPFInputComponent extends StatelessWidget {
  final bool enabled;
  final String? labelText;
  final EdgeInsets padding;
  final FormFields? formFields;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const CPFInputComponent({
    Key? key,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.onFieldSubmitted,
    required this.formFields,
    this.padding = Paddings.inputPaddingForms,
    this.labelText = Strings.cpfInputLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: TextFormField(
        enabled: enabled,
        focusNode: formFields?.focus,
        style: TextStyles.inputTextStyle,
        controller: formFields?.controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.go,
        validator: validator ?? Validators.cpf,
        decoration: InputDecoration(
          labelText: labelText,
          border: Decorations.inputBorderForms,
          contentPadding: Paddings.inputContentPadding,
          fillColor: enabled ? null : AppColors.secondary.withOpacity(0.1),
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
