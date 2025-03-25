import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../values/values.dart';
import 'models/card_edit_item.dart';

class CardEditComponent extends StatelessWidget {
  final CardEditItem editItem;
  final VoidCallback onTap;

  const CardEditComponent({
    Key? key,
    required this.editItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.grey100,
      margin: const EdgeInsets.only(bottom: 16),
      shape: Decorations.cardEditShapeBorder,
      child: InkWell(
        onTap: onTap,
        highlightColor: AppColors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          child: _listTile(),
          padding: Paddings.listTilePadding,
        ),
      ),
    );
  }

  Widget _listTile() {
    return ListTile(
      title: _title(),
      leading: _icon(),
    );
  }

  Widget _title() {
    return AutoSizeText(
      editItem.title,
      style: TextStyles.cardEditPersonalTitle,
      textAlign: TextAlign.left,
    );
  }

  Widget _icon() {
    if (editItem.svgIcon != null) {
      return SvgPicture.asset(
        editItem.svgIcon!,
      );
    }
    return Icon(
      editItem.icon,
      size: 40,
      color: AppColors.primary,
    );
  }
}
