import 'package:flutter/material.dart';

import 'package:maria_me_envia/core/core.dart';

class CustomRadio extends StatelessWidget {
  final Color color;
  final bool isActive;
  final Color disableColor;
  final ValueChanged<bool> onChanged;

  const CustomRadio({
    Key? key,
    this.isActive = false,
    required this.onChanged,
    this.color = AppColors.primary,
    this.disableColor = AppColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isActive),
      child: Container(
        width: 18,
        height: 18,
        child: Visibility(
          child: _item(),
          visible: isActive,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2.0,
            color: isActive ? color : disableColor,
          ),
        ),
      ),
    );
  }

  Widget _item() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
