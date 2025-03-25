import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../general_information_controller.dart';
import '../states/general_information_state.dart';
import '../components/screen_header.dart';
import '../../../../core/core.dart';

class WhoIsMariaScreen extends StatefulWidget {
  const WhoIsMariaScreen({Key? key}) : super(key: key);

  @override
  _WhoIsMariaScreenState createState() => _WhoIsMariaScreenState();
}

class _WhoIsMariaScreenState extends State<WhoIsMariaScreen> {
  final _controller = Modular.get<GeneralInformationController>();

  @override
  void initState() {
    _controller.init(MariaInformationParams.whoIsMaria);
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
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<GeneralInformationState>(
      stream: _controller.informationStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is GeneralInformationErrorState) {
          return _content(errorText: states.message);
        }

        if (states is GeneralInformationLoadingState) {
          return const Center(
            child: LoadingBody(),
          );
        }

        if (states is GeneralInformationSucessState) {
          return _content(information: states.information);
        }

        return Container();
      },
    );
  }

  Widget _content({
    String? errorText,
    MariaInformation? information,
  }) {
    if (errorText == null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _header(information?.picture),
            Padding(
              padding: Paddings.whoIsMariaBody,
              child: _contentSucess(information?.text),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: context.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(null),
          Padding(
            child: _contentSucess(errorText),
            padding: Paddings.tabBarItemsHorizontal,
          ),
        ],
      ),
    );
  }

  Widget _header(String? picture) {
    return SreenHeader(
      media: picture,
    );
  }

  Widget _contentSucess(
    String? text,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _rowText(
          text: Strings.whoIsMaria,
          textStyle: TextStyles.learnMoreTitleStyle,
        ),
        const VerticalSpacing(8),
        _rowText(
          text: Strings.whoIsMariaSubtitle,
          textStyle: TextStyles.whoIsMariaSubtitle,
        ),
        const VerticalSpacing(24),
        _rowText(
          text: text ?? '',
          textStyle: TextStyles.whoIsMariaContentStyle,
        ),
      ],
    );
  }

  Widget _rowText({
    String text = '',
    TextStyle? textStyle,
    TextAlign textAlign = TextAlign.left,
  }) {
    return AutoSizeText(
      text,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
