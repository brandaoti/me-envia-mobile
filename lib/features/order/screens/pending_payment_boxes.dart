import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

import '../components/components.dart';
import '../states/requested_box_states.dart';

import 'requested_boxes/requested_boxes_controller.dart';

class PendingPaymentBoxes extends StatefulWidget {
  const PendingPaymentBoxes({Key? key}) : super(key: key);

  @override
  _PendingPaymentBoxesState createState() => _PendingPaymentBoxesState();
}

class _PendingPaymentBoxesState extends State<PendingPaymentBoxes> {
  final _controller = Modular.get<RequestedBoxController>();

  @override
  void initState() {
    _controller.init(PackageSection.pending);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacing(24),
          _title(),
          const VerticalSpacing(40),
          _body(),
          const VerticalSpacing(40),
        ],
      ),
    );
  }

  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        Strings.pendingPayment,
        textAlign: TextAlign.left,
        style: TextStyles.orderBoxProduct.copyWith(
          height: 1.2,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<RequestedBoxState>(
      stream: _controller.requestedBoxStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is RequestedBoxLoadingState) {
          return const Loading(useContainerBox: true);
        }

        if (states is RequestedBoxErrorState) {
          return _noItems();
        }

        if (states is RequestedBoxSucessState) {
          return _content(states.pack..sortByAmountToPay);
        }

        return Container();
      },
    );
  }

  Widget _content(PackageList pack) {
    return Visibility(
      visible: pack.isNotEmpty,
      replacement: _noItems(),
      child: Column(
        children: pack.map((e) => _requestCard(e)).toList(),
      ),
    );
  }

  Widget _noItems() {
    return const ErrorText(
      height: null,
      message: Strings.noPaymentPedengBox,
    );
  }

  Widget _requestCard(Package package) {
    return Padding(
      child: RequestedBoxCard(
        isPayment: true,
        package: package,
        onPressed: _controller.navigateToCheckoutPayment,
      ),
      padding: const EdgeInsets.only(bottom: 24),
    );
  }
}
