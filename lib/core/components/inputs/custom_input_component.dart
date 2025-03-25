import 'package:flutter/material.dart';

import 'package:maria_me_envia/core/values/values.dart';

class CustomInputComponent extends StatelessWidget {
  final String? label;
  final Function? onValidate;
  final ValueChanged<String?>? onChanged;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomInputComponent({
    Key? key,
    required this.label,
    this.onValidate,
    this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: Decorations.inputBorderForms,
        ),
        validator: (value) => onValidate!(value),
        onChanged: (value) => onChanged?.call(value),
      ),
    );
  }
}
