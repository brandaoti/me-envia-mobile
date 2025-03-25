import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class CardStockAddressComponent extends StatelessWidget {
  final String userName;
  final CardStockAddress? addressInformation;

  const CardStockAddressComponent({
    Key? key,
    required this.userName,
    this.addressInformation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        Expanded(
          child: Visibility(
            visible: addressInformation == null,
            child: _addresDefaultInformation(),
            replacement: _userAddressInformation(),
          ),
        )
      ],
    );
  }

  Widget _icon() {
    return Container(
      width: Dimens.orderCardProfileSize,
      height: Dimens.orderCardProfileSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.grey200,
      ),
      child: const Center(
        child: Icon(Icons.pin_drop, size: 32, color: AppColors.secondary),
      ),
    );
  }

  Widget _addresDefaultInformation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _addresstext(
          text: userName,
          style: TextStyles.cardStockAddressTitle,
        ),
        const VerticalSpacing(8),
        ..._applicationAddressInformation(),
      ],
    );
  }

  List<Widget> _applicationAddressInformation() {
    final int length = Strings.cardStockAddress.length;
    return List.generate(
      length,
      (index) => _addresstext(
        text: Strings.cardStockAddress[index] ?? '',
        style: TextStyles.cardStockAddressSubtitle,
      ),
    );
  }

  Widget _userAddressInformation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _addresstext(
          isTitle: true,
          style: TextStyles.cardStockAddressTitle,
          text: addressInformation?.userName ?? '',
        ),
        const VerticalSpacing(8),
        _addresstext(
          text: addressInformation?.fullStreetName ?? '',
          style: TextStyles.cardStockAddressSubtitle,
        ),
        _addresstext(
          text: addressInformation?.getCpfWithMaks ?? '',
          style: TextStyles.cardStockAddressSubtitle,
        ),
        _addresstext(
          text: addressInformation?.getFullLocation ?? '',
          style: TextStyles.cardStockAddressSubtitle,
        ),
        _addresstext(
          text: addressInformation?.getZipCodeWithMaks ?? '',
          style: TextStyles.cardStockAddressSubtitle,
        ),
        _addresstext(
          text: addressInformation?.address?.complement ?? '',
          style: TextStyles.cardStockAddressSubtitle,
        ),
      ],
    );
  }

  Widget _addresstext({
    required String text,
    bool isTitle = false,
    required TextStyle style,
  }) {
    return AutoSizeText(
      text,
      style: style,
      maxLines: 1,
      textAlign: TextAlign.start,
      minFontSize: isTitle ? 16 : 12,
    );
  }
}
