import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'mantras_controller.dart';

class MantrasScreen extends StatefulWidget {
  const MantrasScreen({Key? key}) : super(key: key);

  @override
  _MantrasScreenState createState() => _MantrasScreenState();
}

class _MantrasScreenState
    extends ModularState<MantrasScreen, MantrasController> {
  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: Paddings.bodyHorizontal,
      width: double.infinity,
      height: context.screenHeight,
      alignment: Alignment.center,
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          _logo(),
          const VerticalSpacing(24),
          _mantrasMessages(context),
        ],
      ),
    );
  }

  Widget _logo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SvgPicture.asset(
        Svgs.logoMantrasSvg,
      ),
    );
  }

  Widget _mantrasMessages(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const HorizontalSpacing(30),
        _verticalLine(context),
        const HorizontalSpacing(60),
        Expanded(child: _mantras(context)),
      ],
    );
  }

  Widget _verticalLine(BuildContext context) {
    return Container(
      height: 135,
      width: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.grey300,
      ),
    );
  }

  Widget _mantras(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.screenWidth,
          child: _messages(),
        ),
        const VerticalSpacing(8),
        _title(),
      ],
    );
  }

  Widget _title() {
    return AutoSizeText(
      Strings.mantraOfMaria,
      style: TextStyles.mantraStyleTitle,
    );
  }

  Widget _messages() {
    return AutoSizeText(
      controller.getCurrentMantra,
      textAlign: TextAlign.start,
      style: TextStyles.mantraStyleMessage,
    );
  }
}
