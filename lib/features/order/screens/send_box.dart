import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../order.dart';
import '../states/requested_box_states.dart';

class SendBox extends StatefulWidget {
  const SendBox({Key? key}) : super(key: key);

  @override
  _SendBoxState createState() => _SendBoxState();
}

class _SendBoxState extends State<SendBox> {
  final _controller = Modular.get<RequestedBoxController>();

  @override
  void initState() {
    _controller.init(PackageSection.sent);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const VerticalSpacing(24),
          _title(),
          const VerticalSpacing(24),
          _content(),
        ],
      ),
    );
  }

  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        Strings.lastSend,
        textAlign: TextAlign.left,
        style: TextStyles.orderBoxProduct.copyWith(
          height: 1.2,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _content() {
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
          return _listOfSendBox(states.pack);
        }

        return Container();
      },
    );
  }

  Widget _listOfSendBox(PackageList list) {
    return Visibility(
      visible: list.isNotEmpty,
      replacement: _noItems(),
      child: Column(
        children: list.map(_sendBoxItem).toList(),
      ),
    );
  }

  Widget _noItems() {
    return const ErrorText(
      height: null,
      message: Strings.noSendBox,
    );
  }

  Widget _sendBoxItem(Package package) {
    return Padding(
      child: CardSendBox(package: package),
      padding: const EdgeInsets.only(bottom: 24),
    );
  }
}
