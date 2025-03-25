import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class CardRecipientAddressComponent extends StatelessWidget {
  final String addressTitle;
  final String recipientInformation;

  const CardRecipientAddressComponent({
    Key? key,
    this.addressTitle = 'Lorem ipsum',
    this.recipientInformation = 'Lorem ipsum',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: _body(),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _icon(),
        const HorizontalSpacing(24),
        _addresInformation(),
      ],
    );
  }

  Widget _icon() {
    return Container(
      width: Dimens.cardSendBoxHeight,
      height: Dimens.cardSendBoxHeight,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.grey200,
      ),
      child: const Center(
        child: Icon(Icons.pin_drop, size: 32, color: AppColors.secondary),
      ),
    );
  }

  Widget _addresInformation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _addressText(
          text: addressTitle,
          style: TextStyles.cardStockAddressTitle,
        ),
        const VerticalSpacing(8),
        _addressText(
          text: recipientInformation,
          style: TextStyles.cardStockAddressSubtitle,
        ),
      ],
    );
  }

  Widget _addressText({
    required String text,
    required TextStyle style,
  }) {
    return AutoSizeText(
      text,
      style: style,
      textAlign: TextAlign.start,
    );
  }
}
