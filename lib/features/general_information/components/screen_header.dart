import 'package:flutter/material.dart';

import '../../../core/core.dart';

class SreenHeader extends StatelessWidget {
  final double height;
  final String? media;
  final Color iconColor;
  final double iconSize;

  const SreenHeader({
    Key? key,
    this.height = 240.0,
    required this.media,
    this.iconSize = 34.0,
    this.iconColor = AppColors.secondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _media(),
        Positioned(
          top: 24,
          left: 24,
          child: _backButton(context),
        ),
      ],
    );
  }

  Widget _media() {
    if ((media ?? '').isEmpty) {
      return SizedBox(
        height: height,
        width: double.infinity,
      );
    }

    return ImageCachedLoading(
      height: height,
      imageUrl: media,
      width: double.infinity,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
      width: iconSize,
      height: iconSize,
      child: IconButton(
        color: iconColor,
        padding: Paddings.zero,
        icon: const BackButtonIcon(),
        onPressed: () => Navigator.maybePop(context),
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteDefault,
      ),
    );
  }
}
