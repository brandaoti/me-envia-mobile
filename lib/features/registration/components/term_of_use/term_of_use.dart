import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../states/registration_state.dart';
import 'term_of_use_controller.dart';
import '../../../../core/core.dart';

class TermOfUse extends StatefulWidget {
  final Widget headerWidget;
  final TermOfUseController controller;
  final VoidCallback? onFinishRegistration;
  final Stream<RegistrationState> registrationStateStream;

  const TermOfUse({
    Key? key,
    required this.controller,
    required this.headerWidget,
    required this.onFinishRegistration,
    required this.registrationStateStream,
  }) : super(key: key);

  @override
  _TermOfUseState createState() => _TermOfUseState();
}

class _TermOfUseState extends State<TermOfUse> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerSection(),
          _bodySection(),
          const VerticalSpacing(32),
          _bottomSection(),
          const VerticalSpacing(32),
        ],
      ),
    );
  }

  Widget _headerSection() {
    return Column(
      children: [
        widget.headerWidget,
        _title(),
      ],
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.termOfUseTitle,
      minFontSize: 16,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationTermOfUseTitle,
    );
  }

  Widget _bodySection() {
    return FutureBuilder<String>(
      future: widget.controller.loadPrivacyPolicyApp(),
      builder: (context, snapshot) {
        final connection = snapshot.connectionState;

        switch (connection) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: Loading(
                useContainerBox: true,
                height: Dimens.onboardingAssetSize,
              ),
            );
          case ConnectionState.done:
          case ConnectionState.active:
            return _privacyPolicyDescription(snapshot.data!);
        }
      },
    );
  }

  Widget _privacyPolicyDescription(String termOfUse) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: Dimens.onboardingAssetSize,
      ),
      child: Scrollbar(
        radius: const Radius.circular(8),
        child: SingleChildScrollView(
          padding: Paddings.vertical,
          child: AutoSizeText(
            termOfUse,
            minFontSize: 12,
            textAlign: TextAlign.justify,
            style: TextStyles.termOfUseDocs,
          ),
        ),
      ),
    );
  }

  Widget _bottomSection() {
    return StreamBuilder<bool>(
      stream: widget.controller.termOfUseAcceptedStream,
      builder: (context, snapshot) {
        final isAccepted = snapshot.data ?? false;
        return Column(
          children: [
            _acceptTermOfuseCheckBox(isAccepted),
            const VerticalSpacing(16),
            _onSubmittedButton(isAccepted),
          ],
        );
      },
    );
  }

  Widget _acceptTermOfuseCheckBox(
    bool isAcceptedTermOfUse,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCheckBox(
          value: isAcceptedTermOfUse,
          onChanged: widget.controller.acceptTermOfuse,
        ),
        const HorizontalSpacing(16),
        Expanded(
          child: Container(
            height: 24,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const AutoSizeText(
              Strings.acceptTermOfUse,
              minFontSize: 12,
              style: TextStyles.resgitrationAccepTermOfUse,
            ),
          ),
        )
      ],
    );
  }

  Widget _onSubmittedButton(bool isAcceptedTermOfUse) {
    return StreamBuilder<RegistrationState>(
      stream: widget.registrationStateStream,
      builder: (context, snapshot) {
        final registrationState = snapshot.data;
        return DefaultButton(
          isValid: isAcceptedTermOfUse,
          onPressed: widget.onFinishRegistration,
          title: Strings.finishRegistration,
          isLoading: registrationState is RegistrationLoadingState,
        );
      },
    );
  }
}
