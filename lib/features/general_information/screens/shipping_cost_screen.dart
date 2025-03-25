import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../general_information_controller.dart';
import '../states/general_information_state.dart';
import '../components/screen_header.dart';
import '../../../../core/core.dart';

class ShippingCostScreen extends StatefulWidget {
  const ShippingCostScreen({Key? key}) : super(key: key);

  @override
  _OurServiceScreenState createState() => _OurServiceScreenState();
}

class _OurServiceScreenState extends State<ShippingCostScreen> {
  final _controller = Modular.get<GeneralInformationController>();

  @override
  void initState() {
    _controller.init(MariaInformationParams.ourService);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<GeneralInformationState>(
      stream: _controller.informationStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is GeneralInformationErrorState) {
          return _errorStates(states.message);
        }

        if (states is GeneralInformationLoadingState) {
          return Center(
            child: SizedBox(
              child: const LoadingBody(),
              height: context.screenHeight,
            ),
          );
        }

        if (states is GeneralInformationSucessState) {
          return _content(states.information);
        }

        return Container();
      },
    );
  }

  Widget _errorStates(String error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SreenHeader(
          media: null,
        ),
        const VerticalSpacing(24),
        Padding(
          padding: Paddings.bodyHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              const VerticalSpacing(8),
              _subtitle(),
              const VerticalSpacing(24),
              AutoSizeText(
                error,
                style: TextStyles.whoIsMariaContentStyle,
              ),
              const VerticalSpacing(38),
            ],
          ),
        ),
      ],
    );
  }

  Widget _content(
    MariaInformation information,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SreenHeader(
          media: information.picture,
        ),
        const VerticalSpacing(32),
        Padding(
          padding: Paddings.bodyHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              const VerticalSpacing(8),
              _subtitle(),
              const VerticalSpacing(24),
              _message(information.text),
              const VerticalSpacing(38),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.shippingCost,
      style: TextStyles.learnMoreTitleStyle,
    );
  }

  Widget _subtitle() {
    return const AutoSizeText(
      Strings.welcomeToMariaMeEnvia,
      style: TextStyles.whoIsMariaSubtitle,
    );
  }

  Widget _message(String text) {
    return AutoSizeText(
      text,
      minFontSize: 14,
      textAlign: TextAlign.left,
      style: TextStyles.whoIsMariaSubtitle.copyWith(
        height: 1.6,
        fontSize: 18,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
