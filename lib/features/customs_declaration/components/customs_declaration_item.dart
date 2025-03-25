import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';
import '../customs_declaration.dart';

class CustomsDeclarationItem extends StatelessWidget {
  final int index;
  final VoidCallback? onPressed;
  final DeclarationSection section;
  final ItemDeclaration declaration;

  const CustomsDeclarationItem({
    Key? key,
    this.onPressed,
    required this.index,
    required this.declaration,
    this.section = DeclarationSection.create,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        child: _body(),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: Decorations.cardOrderItem(false),
        constraints: const BoxConstraints(minHeight: 146),
      ),
    );
  }

  Widget _body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iconCheck(),
        Expanded(
          child: _itemInformation(),
        ),
        _iconEditItem(),
      ],
    );
  }

  Widget _itemInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.vertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            Strings.customsDeclarationItemTitle(
              index.toString(),
              declaration.quantity.toString(),
            ),
            style: TextStyles.cardDeclarationItemTitle,
          ),
          const VerticalSpacing(4),
          _itemInformationText(
            declaration.category,
          ),
          _itemInformationText(
            declaration.description,
          ),
          _itemInformationText(
            Strings.customsDeclarationItemValue(
              declaration.formatterUnityValue,
              false,
            ),
          ),
          _itemInformationText(
            Strings.customsDeclarationItemValue(
              declaration.formatterTotalValue,
              true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemInformationText(String? text) {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        text ?? '',
        overflow: TextOverflow.ellipsis,
        style: TextStyles.cardDeclarationItemSubtitle,
      ),
    );
  }

  Widget _iconCheck() {
    return Container(
      width: 56,
      height: 56,
      child: const Icon(
        Icons.check_rounded,
        size: 32,
        color: AppColors.alertGreenColor,
      ),
      decoration: Decorations.cardOrderItem(false).copyWith(
        color: AppColors.alertGreenColorLight,
        borderRadius: BorderRadius.circular(56),
      ),
    );
  }

  Widget _iconEditItem() {
    final mappingSections = {
      DeclarationSection.create: false,
      DeclarationSection.editing: false,
      DeclarationSection.completed: true,
    };

    return Visibility(
      visible: mappingSections[section] ?? false,
      child: InkWell(
        onTap: onPressed,
        child: const Icon(
          Icons.edit,
          size: 28,
          color: AppColors.black,
        ),
      ),
    );
  }
}
