import 'package:flutter_modular/flutter_modular.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../general_information_controller.dart';
import '../states/faq_state.dart';
import '../../../core/core.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final _controller = Modular.get<GeneralInformationController>();

  @override
  void initState() {
    _controller.handleGetAllFaq();
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
      appBar: AppBar(
        leading: _backButton(),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _backButton() {
    return StreamBuilder<FaqState>(
      stream: _controller.faqStateStream,
      builder: (context, snapshot) => Visibility(
        visible: snapshot.data is! FaqStateLoadingState,
        child: const BackButton(
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: const AutoSizeText(
        Strings.faq,
        style: TextStyles.learnMoreTitleStyle,
      ),
    );
  }

  Widget _subtitle() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: AutoSizeText(
        Strings.faqSubtitle,
        textAlign: TextAlign.center,
        style: TextStyles.whoIsMariaSubtitle.copyWith(
          height: 1.2,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<FaqState>(
      stream: _controller.faqStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is FaqStateErrorState) {
          return _errorStates(states.message);
        }

        if (states is FaqStateLoadingState) {
          return Center(
            child: SizedBox(
              child: const LoadingBody(),
              height: context.screenHeight,
            ),
          );
        }

        if (states is FaqStateSucessState) {
          return _content(states.list);
        }

        return Container();
      },
    );
  }

  Widget _errorStates(String error) {
    return Padding(
      padding: Paddings.bodyHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          const VerticalSpacing(8),
          _subtitle(),
          const VerticalSpacing(24),
          AutoSizeText(
            error,
            style: TextStyles.whoIsMariaContentStyle,
          ),
        ],
      ),
    );
  }

  Widget _content(List<Faq> list) {
    return SingleChildScrollView(
      padding: Paddings.bodyHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VerticalSpacing(24),
          _title(),
          const VerticalSpacing(32),
          _subtitle(),
          const VerticalSpacing(32),
          Column(
            children: list.map(_faqCard).toList(),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          const VerticalSpacing(32),
        ],
      ),
    );
  }

  Widget _faqCard(Faq faq) {
    return Padding(
      child: ExpansionCard(
        body: faq.answer,
        title: faq.question,
      ),
      padding: const EdgeInsets.only(bottom: 24),
    );
  }
}
