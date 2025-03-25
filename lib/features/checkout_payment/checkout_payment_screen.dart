import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../features/features.dart';
import '../../core/core.dart';

import 'states/open_proof_of_payment_state.dart';
import 'components/payment_upload_file.dart';
import 'states/upload_file_state.dart';

typedef BuilderOpenFileState = Widget Function(OpenProofOfPaymentState?);

class CheckoutPaymentScreen extends StatefulWidget {
  final Package package;

  const CheckoutPaymentScreen({
    Key? key,
    required this.package,
  }) : super(key: key);

  @override
  _CheckoutPaymentScreenState createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState
    extends ModularState<CheckoutPaymentScreen, CheckoutPaymentController> {
  @override
  void initState() {
    controller.init(widget.package);
    _startListener();
    super.initState();
  }

  void _startListener() {
    controller.uploadFileStateStream.listen((states) async {
      if (states is UploadFileErrorState) {
        _showErrorState(states.message);
      }

      if (states is UploadFileSucessState) {
        controller.navigateToOrderScreen();
      }
    });
  }

  void _showErrorState(String message) {
    ActionToErrorState(
      helper: '',
      context: context,
      message: message,
      buttonText: Strings.tryAgain,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _backButton(),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _backButton() {
    return StreamBuilder<UploadFileState>(
      stream: controller.uploadFileStateStream,
      builder: (context, snapshot) => Visibility(
        child: const BackButton(
          color: AppColors.black,
        ),
        visible: snapshot.data is! UploadFileSucessState,
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<UploadFileState>(
      stream: controller.uploadFileStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;
        return Visibility(
          replacement: _content(),
          child: _doneUploadProofOfPayment(),
          visible: states is UploadFileSucessState,
        );
      },
    );
  }

  Widget _doneUploadProofOfPayment() {
    return const Center(
      child: Padding(
        child: Done(),
        padding: Paddings.bodyHorizontal,
      ),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      padding: Paddings.bodyHorizontal,
      child: Column(
        children: [
          const VerticalSpacing(24),
          _title(),
          const VerticalSpacing(64),
          _totalValue(),
          const VerticalSpacing(56),
          _paymentInformation(),
          const VerticalSpacing(40),
          _proofOfPayment(),
          const VerticalSpacing(56),
          _buttonUploadFile(),
          const VerticalSpacing(24),
        ],
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.paymentTitle,
      style: TextStyles.modalConfirmOrderTitleStyle.copyWith(
        fontSize: 38,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _totalValue() {
    final shippingFeeValue = widget.package.shippingFee?.byReal();
    return AutoSizeText(
      shippingFeeValue?.formatterMoneyToBrasilian ?? '',
      style: TextStyles.modalConfirmOrderTitleStyle.copyWith(
        fontSize: 50,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _paymentInformation() {
    return Container(
      width: double.infinity,
      padding: Paddings.listTilePadding,
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                Strings.informationOfPayment.map(_informationText).toList(),
          ),
          const VerticalSpacing(16),
          _copyButton(),
        ],
      ),
    );
  }

  Widget _informationText(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 2),
      child: AutoSizeText(
        text,
        textAlign: TextAlign.left,
        style: TextStyles.modalConfirmOrderTitleStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _copyButton() {
    return TextButton.icon(
      icon: _iconCopy(),
      label: _labelCopy(),
      onPressed: () => controller.handleCopyAddress(context),
      style: TextButton.styleFrom(
        primary: AppColors.secondary,
        padding: Paddings.copyButton,
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
      Strings.copyPaymentInfo,
      style: TextStyles.copyAddress,
      textAlign: TextAlign.center,
    );
  }

  Widget _proofOfPayment() {
    return StreamBuilder<UploadFileState>(
      stream: controller.uploadFileStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        return PaymentUploadFile(
          isLoading: states is UploadFileLoadingState,
          onPressed: controller.handleGetFileInDocument,
          stream: controller.openProofOfPaymentStateStream,
        );
      },
    );
  }

  Widget _openFileStates({
    required BuilderOpenFileState builder,
  }) {
    return StreamBuilder<OpenProofOfPaymentState>(
      stream: controller.openProofOfPaymentStateStream,
      builder: (context, snapshot) => builder(snapshot.data),
    );
  }

  Widget _buttonUploadFile() {
    return StreamBuilder<UploadFileState>(
      stream: controller.uploadFileStateStream,
      builder: (context, snapshot) {
        final uploadStates = snapshot.data;

        return _openFileStates(
          builder: (state) {
            return DefaultButton(
              title: Strings.sendProofOfPayment,
              onPressed: controller.handleUploadFile,
              isValid: state is OpenProofOfPaymentSucessState,
              isLoading: uploadStates is UploadFileLoadingState,
            );
          },
        );
      },
    );
  }
}
