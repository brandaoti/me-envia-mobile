import 'package:flutter/material.dart';

import 'package:maria_me_envia/core/values/values.dart';

class Loading extends StatelessWidget {
  final Color color;
  final double height;
  final bool useContainerBox;

  const Loading({
    Key? key,
    this.color = AppColors.primary,
    this.height = 258,
    this.useContainerBox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: useContainerBox,
      replacement: _loadingItem(),
      child: Container(
        height: height,
        child: _loadingItem(),
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _loadingItem() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
