import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../states/general_information_state.dart';
import '../general_information_controller.dart';
import '../components/card_information.dart';
import '../components/screen_header.dart';
import '../../../core/core.dart';

class ServiceTaxesScreen extends StatefulWidget {
  const ServiceTaxesScreen({Key? key}) : super(key: key);

  @override
  _ServiceTaxesScreenState createState() => _ServiceTaxesScreenState();
}

class _ServiceTaxesScreenState extends State<ServiceTaxesScreen> {
  final _controller = Modular.get<GeneralInformationController>();

  @override
  void initState() {
    _controller.init(MariaInformationParams.serviceFees);
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
              CardInformation(
                icon: Icons.attach_money,
                subtitle: information.subtitle,
                title: Strings.serviceTaxesCardTitle,
              ),
              const VerticalSpacing(24),
              CardInformation(
                icon: MdiIcons.weight,
                subtitle: information.text,
                subtitleColor: AppColors.secondary,
                title: Strings.maxVolumeAllowedCardTitle,
              ),
              const VerticalSpacing(38),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.serviceTaxes,
      style: TextStyles.learnMoreTitleStyle,
    );
  }

  Widget _subtitle() {
    return const AutoSizeText(
      Strings.serviceTaxesSubtitle,
      style: TextStyles.whoIsMariaSubtitle,
    );
  }
}
