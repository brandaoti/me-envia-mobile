import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../models/new_address.dart';

class CreatedNewRecipient extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onEdit;
  final NewAddress newAddress;
  final VoidCallback onConfirm;

  const CreatedNewRecipient({
    Key? key,
    required this.onEdit,
    required this.onConfirm,
    required this.isLoading,
    required this.newAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _illustration(),
        const VerticalSpacing(40),
        _title(),
        const VerticalSpacing(16),
        _address(),
        const VerticalSpacing(32),
        _confirmBtn(),
        const VerticalSpacing(16),
        _editBoxBtn(),
        const VerticalSpacing(36),
      ],
    );
  }

  Widget _illustration() {
    return Center(
      child: SvgPicture.asset(
        Svgs.forgotPassword02,
        width: 280,
        height: 280,
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.recipientCreated,
      textAlign: TextAlign.center,
      style: TextStyles.orderBoxProduct.copyWith(
        height: 1.2,
        fontWeight: FontWeight.w900,
        fontSize: 26,
      ),
    );
  }

  Widget _address() {
    return CardStockAddressComponent(
      userName: '',
      addressInformation: CardStockAddress(
        cpf: newAddress.cpf,
        userName: newAddress.name,
        address: newAddress.address,
      ),
    );
  }

  Widget _confirmBtn() {
    return DefaultButton(
      isValid: true,
      onPressed: onConfirm,
      isLoading: isLoading,
      title: Strings.forgotPasswordButtonTitleConfirm,
    );
  }

  Widget _editBoxBtn() {
    return BordLessButton(
      onPressed: onEdit,
      title: Strings.editAdress,
      isValid: true && !isLoading,
    );
  }
}
