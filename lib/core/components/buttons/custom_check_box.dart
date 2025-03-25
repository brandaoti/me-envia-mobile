import 'package:flutter/material.dart';

import '../../values/app_colors.dart';
import '../../values/durations.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        width: 24,
        height: 24,
        child: _child(),
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2.0, color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _child() {
    final double sizeContanier = value ? 0 : 16;
    return Visibility(
      visible: value,
      child: AnimatedContainer(
        width: sizeContanier,
        height: sizeContanier,
        duration: Durations.transition,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
