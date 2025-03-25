import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maria_me_envia/core/components/components.dart';

class ImageCachedLoading extends StatelessWidget {
  final BoxFit fit;
  final double radius;
  final double? width;
  final double? height;
  final String? imageUrl;
  final bool visibleLoadingProcess;
  final BorderRadius? borderRadius;

  const ImageCachedLoading({
    Key? key,
    this.width,
    this.height,
    this.radius = 0,
    this.borderRadius,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.visibleLoadingProcess = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((imageUrl ?? '').isEmpty) {
      return Container();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: fit,
        width: width,
        height: height,
        imageUrl: imageUrl!,
        errorWidget: (_, url, error) => const Icon(Icons.error),
        placeholder: (_, url) => Visibility(
          visible: visibleLoadingProcess,
          child: const Center(child: Loading()),
        ),
      ),
    );
  }
}
