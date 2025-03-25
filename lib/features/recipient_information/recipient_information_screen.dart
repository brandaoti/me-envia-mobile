import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'package:maria_me_envia/core/core.dart';
import 'recipient_information_controller.dart';
import 'states/recipient_user_state.dart';

class RecipientInformation extends StatefulWidget {
  final BoxList boxList;

  const RecipientInformation({
    Key? key,
    required this.boxList,
  }) : super(key: key);

  @override
  _RecipientInformationState createState() => _RecipientInformationState();
}

class _RecipientInformationState
    extends ModularState<RecipientInformation, RecipientInformationController> {
  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: const BackButton(
        color: AppColors.secondary,
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: Paddings.bodyHorizontal,
      child: Column(
        children: [
          const VerticalSpacing(38),
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
      ),
    );
  }

  Widget _illustration() {
    return Center(
      child: SvgPicture.asset(
        Svgs.stockAddressSvg,
        width: Dimens.imageSize230PX,
        height: Dimens.imageSize230PX,
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.recipientInformationText,
      textAlign: TextAlign.center,
      style: TextStyles.orderBoxProduct.copyWith(
        height: 1.2,
        fontWeight: FontWeight.w900,
        fontSize: 26,
      ),
    );
  }

  Widget _address() {
    return StreamBuilder<RecipientUserState>(
      stream: controller.recipientUserState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is RecipientUserSucessState) {
          return CardStockAddressComponent(
            userName: '',
            addressInformation: CardStockAddress(
              cpf: state.user?.cpf ?? '',
              address: state.user?.address,
              userName: state.user?.name ?? '',
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _confirmBtn() {
    return DefaultButton(
      isValid: true,
      title: Strings.recipientAddressBtn.first,
      onPressed: () => controller.navigateToCustomDeclaration(widget.boxList),
    );
  }

  Widget _editBoxBtn() {
    return BordLessButton(
      isValid: true,
      title: Strings.recipientAddressBtn.last,
      onPressed: () => controller.navigateToNewRecipientScreen(widget.boxList),
    );
  }
}
