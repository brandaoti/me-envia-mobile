import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

class SendBoxGridItems extends StatelessWidget {
  final BoxList items;
  final VoidCallback onPressed;

  const SendBoxGridItems({
    Key? key,
    required this.items,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.verticalTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _totalItens(),
          const VerticalSpacing(24),
          _generatedBoxItems(),
        ],
      ),
    );
  }

  Widget _totalItens() {
    return AutoSizeText(
      Strings.lenghtBoxItems(items.length),
      maxLines: 1,
      minFontSize: 16,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.boxTitleStyle.copyWith(
        color: AppColors.pureblack,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _generatedBoxItems() {
    const double gridMaxHeight = 138;

    if (items.length == 1) {
      return Container(
        height: gridMaxHeight,
        width: double.infinity,
        decoration: Decorations.sendBoxCard.copyWith(
          image: _getImageProviderWithPackgaItems(media: items.first.media),
        ),
      );
    }

    final bool hasMoreThanThreeItems = items.length >= 3;

    final double maxHeight =
        hasMoreThanThreeItems ? gridMaxHeight : (gridMaxHeight / 2);

    return TweenAnimationBuilder<BoxConstraints>(
      tween: BoxConstraintsTween(
        begin: const BoxConstraints(maxHeight: 0),
        end: BoxConstraints(maxHeight: maxHeight),
      ),
      duration: Durations.transition,
      builder: (context, constraints, child) => Container(
        constraints: constraints,
        child: _generatedGridItems(
          items: items.length >= 4 ? items.sublist(0, 4) : items,
        ),
      ),
    );
  }

  Widget _generatedGridItems({required BoxList items}) {
    final int itemCount = items.length + 1;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        mainAxisExtent: 60.0,
      ),
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if ((index + 1) == itemCount) {
          return _seeAllImagesButton();
        }

        return Container(
          width: double.infinity,
          decoration: Decorations.sendBoxCard.copyWith(
            image: _getImageProviderWithPackgaItems(media: items[index].media),
          ),
        );
      },
    );
  }

  Widget _seeAllImagesButton() {
    return DefaultButton(
      radius: 8,
      fontSize: 16,
      isValid: true,
      onPressed: onPressed,
      fontWeight: FontWeight.w600,
      title: Strings.seeAllButtonText,
    );
  }

  DecorationImage? _getImageProviderWithPackgaItems({
    required String? media,
    BoxFit fit = BoxFit.cover,
  }) {
    if ((media ?? '').isEmpty) return null;

    return DecorationImage(image: NetworkImage(media!), fit: fit);
  }
}
