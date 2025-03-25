import 'package:flutter/material.dart';

import '../../values/values.dart';

class ExpansionIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final Animation<double>? iconTurns;

  const ExpansionIcon({
    Key? key,
    this.padding,
    this.onPressed,
    this.iconTurns,
    this.color = AppColors.black,
    this.iconData = Icons.arrow_drop_down_rounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultaPadding = EdgeInsets.all(8.0);

    return IconButton(
      icon: _icon(),
      splashRadius: 12,
      onPressed: onPressed,
      padding: padding ?? defaultaPadding,
    );
  }

  Widget _icon() {
    final child = Icon(
      iconData,
      color: color,
    );

    if (iconTurns != null) {
      return RotationTransition(
        child: child,
        turns: iconTurns!,
      );
    }

    return child;
  }
}
