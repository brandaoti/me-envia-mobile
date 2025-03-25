import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class StockAddressWidget extends StatefulWidget {
  const StockAddressWidget({
    Key? key,
  }) : super(key: key);

  @override
  _StockAddressWidgetState createState() => _StockAddressWidgetState();
}

class _StockAddressWidgetState
    extends ModularState<StockAddressWidget, AuthController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _userName = '';

  @override
  void initState() {
    _startListener();
    super.initState();
  }

  void _startListener() async {
    final user = await controller.getUser();
    setState(() {
      _userName = user?.name ?? '';
    });
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _body(),
          padding: Paddings.bodyHorizontal,
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.whiteDefault,
      leading: BackButton(
        color: AppColors.black,
        onPressed: Modular.to.pop,
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _illustration(),
        const VerticalSpacing(16),
        _cardStockAdress(),
        const VerticalSpacing(24),
        _finishBtn(),
        const VerticalSpacing(24),
      ],
    );
  }

  Widget _illustration() {
    return Column(
      children: [
        SvgPicture.asset(
          Svgs.stockAddressSvg,
          width: Dimens.imageSize250Px,
          height: Dimens.imageSize250Px,
        ),
        const VerticalSpacing(40),
        _title(),
      ],
    );
  }

  Widget _title() {
    return const FittedBox(
      child: AutoSizeText(
        Strings.stockAddressTitle,
        style: TextStyles.stockAddressTitleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _cardStockAdress() {
    return Column(
      children: [
        CardStockAddressComponent(
          userName: _userName,
        ),
        const VerticalSpacing(24),
        _copyButton(
          onPressed: () {
            final copyAddress = Strings.cardStockAddress.values.map((it) => it);
            Helper.copyToClipboard(copyAddress.join('\n'));
            Helper.showSnackBarCopiedToClipboard(context, Strings.street);
          },
        ),
      ],
    );
  }

  Widget _copyButton({
    VoidCallback? onPressed,
  }) {
    return TextButton.icon(
      icon: _iconCopy(),
      label: _labelCopy(),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: AppColors.primary,
        padding: const EdgeInsets.all(20),
      ),
    );
  }

  Widget _iconCopy() {
    return const Icon(
      IconsData.iconCopyAddress,
      size: 24,
      color: AppColors.secondary,
    );
  }

  Widget _labelCopy() {
    return const AutoSizeText(
      Strings.cardStockCopyAddress,
      style: TextStyles.copyAddress,
      textAlign: TextAlign.center,
    );
  }

  Widget _finishBtn() {
    return DefaultButton(
      isValid: true,
      onPressed: Modular.to.pop,
      title: Strings.stockAddressBtnText,
    );
  }
}
