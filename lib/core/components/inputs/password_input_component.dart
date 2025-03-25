import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../values/values.dart';
import '../forms/forms.dart';

class PasswordInputComponent extends StatelessWidget {
  final bool isEnable;
  final String? labelText;
  final EdgeInsets padding;
  final String? errorText;
  final int errorMaxLines;
  final FormFields? formFields;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  final bool obscureText;
  final ValueChanged<bool>? onChangedObscureText;

  const PasswordInputComponent({
    Key? key,
    this.onChanged,
    this.validator,
    this.errorText,
    this.isEnable = true,
    this.onFieldSubmitted,
    this.errorMaxLines = 1,
    this.obscureText = true,
    required this.formFields,
    this.onChangedObscureText,
    this.textInputAction = TextInputAction.go,
    this.padding = Paddings.inputPaddingForms,
    this.labelText = Strings.passwordInputLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        enabled: isEnable,
        obscureText: obscureText,
        focusNode: formFields?.focus,
        textInputAction: textInputAction,
        style: TextStyles.inputTextStyle,
        controller: formFields?.controller,
        keyboardType: TextInputType.visiblePassword,
        validator: validator ?? Validators.password,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          suffixIcon: _suffixIcon(),
          errorMaxLines: errorMaxLines,
          border: Decorations.inputBorderForms,
          contentPadding: Paddings.inputContentPadding,
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }

  Widget _suffixIcon() {
    const _mappToIcons = {
      true: Icons.visibility_off,
      false: Icons.visibility,
    };

    return IconButton(
      onPressed: () => onChangedObscureText?.call(!obscureText),
      icon: Icon(_mappToIcons[obscureText], color: AppColors.black),
    );
  }
}
