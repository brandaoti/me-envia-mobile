import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'package:maria_me_envia/core/core.dart';

class CardInformation extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final Color subtitleColor;

  const CardInformation({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor = AppColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _body(),
      width: double.infinity,
    );
  }

  Widget _body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _icon(),
        Expanded(child: _message()),
      ],
    );
  }

  Widget _icon() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary.withOpacity(0.3),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
    );
  }

  Widget _message() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          title,
          style: TextStyles.whoIsMariaSubtitle.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const VerticalSpacing(8),
        AutoSizeText(
          subtitle,
          minFontSize: 14,
          textAlign: TextAlign.left,
          style: TextStyles.whoIsMariaSubtitle.copyWith(
            height: 1.6,
            fontSize: 14,
            color: subtitleColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
