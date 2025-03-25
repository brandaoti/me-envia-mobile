import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/models/models.dart';
import '../../../core/values/values.dart';

class CardMariaTipsComponent extends StatelessWidget {
  final VoidCallback onTap;
  final MariaTips mariaTips;

  const CardMariaTipsComponent({
    Key? key,
    required this.onTap,
    required this.mariaTips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: InkWell(
        onTap: onTap,
        child: _card(),
        highlightColor: AppColors.transparent,
      ),
      padding: const EdgeInsets.only(bottom: 24),
    );
  }

  Widget _tipsImage() {
    DecorationImage? image;

    if (mariaTips.media != null) {
      image = DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(mariaTips.media!),
      );
    }

    return SizedBox(
      height: Dimens.height80,
      width: double.infinity,
      child: Stack(
        children: [
          _image(
            Decorations.cardTipsDecoration().copyWith(image: image),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _image(
              Decorations.cardTipsDecoration(useBlur: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image(Decoration decoration) {
    return Container(
      decoration: decoration,
      width: double.infinity,
      height: Dimens.height80,
    );
  }

  Widget _card() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppColors.grey200,
      child: Column(
        children: [
          _tipsImage(),
          const VerticalSpacing(10),
          _header(),
          _content(),
          const VerticalSpacing(10),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: Paddings.mariaTipsCardPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _title(),
          ),
          const RotatedBox(
            quarterTurns: 3,
            child: Icon(Icons.arrow_drop_down),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: AutoSizeText(
            mariaTips.title ?? '',
            maxLines: 2,
            style: TextStyles.mariaTipsTitle.copyWith(fontSize: 18),
          ),
        ),
        const VerticalSpacing(8),
        AutoSizeText(
          mariaTips.createdAt.toMonthAndDay,
          style: TextStyles.mariaTipsCardDate,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _content() {
    return Container(
      width: double.infinity,
      padding: Paddings.horizontal,
      child: AutoSizeText(
        mariaTips.description ?? '',
        maxLines: 3,
        minFontSize: 14,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.mariaTipsTitle.copyWith(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
