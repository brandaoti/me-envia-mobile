import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/components/components.dart';
import '../../core/values/values.dart';
import '../features.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  NnoConnectionState createState() => NnoConnectionState();
}

class NnoConnectionState extends State<NoConnection> {
  final _controller = Modular.get<NoConnectionController>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: _body()),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: Paddings.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _illustration(),
          const VerticalSpacing(80),
          _errorsTexts(),
          const VerticalSpacing(80),
          _refreshButton(),
          const VerticalSpacing(16),
          _closeToApp(),
          const VerticalSpacing(20)
        ],
      ),
    );
  }

  Widget _illustration() {
    return Center(
      child: SvgPicture.asset(Svgs.noConnection),
    );
  }

  Widget _errorsTexts() {
    return StreamBuilder<bool>(
      stream: _controller.isLoading,
      builder: (context, snapshot) {
        bool isLoading = snapshot.data ?? false;
        return Visibility(
          visible: !isLoading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              const VerticalSpacing(24),
              _subtitle(),
            ],
          ),
        );
      },
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.errorConnectionTitle,
      textAlign: TextAlign.center,
      style: TextStyles.noConnectionTitle,
    );
  }

  Widget _subtitle() {
    return const AutoSizeText(
      Strings.errorConnectionSubtitle,
      textAlign: TextAlign.center,
      style: TextStyles.noConnectionSubtitle,
    );
  }

  Widget _refreshButton() {
    return StreamBuilder<bool>(
      stream: _controller.isLoading,
      builder: (context, snapshot) {
        bool isLoading = snapshot.data ?? false;
        return DefaultButton(
          isValid: true,
          isLoading: isLoading,
          title: Strings.toUpdate,
          onPressed: _controller.handleCheckConnection,
        );
      },
    );
  }

  Widget _closeToApp() {
    return const BordLessButton(
      title: Strings.closeToApp,
      onPressed: SystemNavigator.pop,
    );
  }
}
