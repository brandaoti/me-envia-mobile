import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../helpers/extensions.dart';
import '../../../values/values.dart';

class SendBoxPackageStatus extends StatelessWidget {
  final String totalItems;
  final bool isExpanded;
  final DateTime updateAt;
  final bool countItemsVisible;
  final Map<String, dynamic> statusState;

  const SendBoxPackageStatus({
    Key? key,
    required this.updateAt,
    required this.totalItems,
    required this.isExpanded,
    required this.statusState,
    this.countItemsVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: isExpanded,
          child: Padding(
            child: _createUpdateBoxDate(),
            padding: const EdgeInsets.only(right: 4),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _circularStatusAndCountItems(),
              Visibility(
                visible: !isExpanded,
                child: _createUpdateBoxDate(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circularStatusAndCountItems() {
    late final Widget child;

    if (statusState['isSvgIcon']) {
      child = Padding(
        padding: Paddings.listTilePadding,
        child: SvgPicture.asset(
          statusState['icon'],
          width: Dimens.sendBoxIconSize,
          height: Dimens.sendBoxIconSize,
          color: statusState['color'],
        ),
      );
    } else {
      child = Icon(
        statusState['icon'],
        size: Dimens.sendBoxIconSize,
        color: statusState['color'],
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: Decorations.boxCarRequestedBox.copyWith(
              color: statusState['background'],
            ),
            child: child,
            width: Dimens.cardSendBoxHeight,
            height: Dimens.cardSendBoxHeight,
          ),
        ),
        Positioned(
          bottom: 0,
          right: -5,
          child: Visibility(
            child: _countItems(),
            visible: countItemsVisible,
          ),
        )
      ],
    );
  }

  Widget _countItems() {
    return Container(
      width: Dimens.horizontal,
      height: Dimens.horizontal,
      alignment: Alignment.center,
      decoration: Decorations.boxCarRequestedBox.copyWith(
        color: AppColors.whiteDefault,
      ),
      child: AutoSizeText(
        totalItems,
        style: TextStyles.boxCountStyle,
      ),
    );
  }

  Widget _createUpdateBoxDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          updateAt.toMonthAbbreStr,
          style: TextStyles.toMonthAbbreStrStyle,
        ),
        const VerticalSpacing(4),
        AutoSizeText(
          updateAt.toHourAbbreStr,
          style: TextStyles.toHourAbbreStrStyle,
        ),
      ],
    );
  }
}
