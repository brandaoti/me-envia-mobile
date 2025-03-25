import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:maria_me_envia/core/values/values.dart';

class CardItensNotificationComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const CardItensNotificationComponent({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.iconColor = AppColors.alertYellowColor,
    this.icon = IconsData.iconAccountBalanceWallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _icon(),
        const HorizontalSpacing(24),
        Expanded(child: _texts()),
      ],
    );
  }

  Widget _texts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _title(),
        SizedBox(
          child: _subtitle(),
          width: double.infinity,
        ),
        const VerticalSpacing(24),
      ],
    );
  }

  Widget _icon() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: iconColor.withOpacity(.2),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 32, color: iconColor),
    );
  }

  Widget _title() {
    return AutoSizeText(
      title,
      textAlign: TextAlign.start,
      style: TextStyles.cardModalItemTitle,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      subtitle,
      textAlign: TextAlign.start,
      style: TextStyles.cardModalItemSubtitle,
    );
  }
}
