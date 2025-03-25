import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

import 'header_states/quotation_states.dart';
import 'header_states/header_states.dart';
import 'carrousel_component.dart';
import 'header_controller.dart';

class HeaderComponent extends StatelessWidget {
  final HeaderController controller;

  const HeaderComponent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _headerTitle(),
        const VerticalSpacing(16),
        _content(),
      ],
    );
  }

  Widget _content() {
    return StreamBuilder<HeaderStates>(
      stream: controller.headerStatesChanged,
      builder: (context, snapshot) {
        final headerStates = snapshot.data;

        if (headerStates is HeaderLoadingState) {
          return _loadingState();
        }

        if (headerStates is HeaderSucessState) {
          final tips = headerStates.tips;
          return Column(
            children: [
              _carrouselImages(tips),
              const VerticalSpacing(12),
              _moreTips(
                onTap: controller.navigateToMariaTipsScreen,
              ),
              const VerticalSpacing(12),
              _stepsWidget(tips.length),
            ],
          );
        }

        if (headerStates is HeaderErrorState) {
          return _loadingState();
        }
        return Container();
      },
    );
  }

  Widget _loadingState() {
    return Container(
      height: 258,
      child: const Loading(),
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _stepsWidget(int lengthStepsGenerated) {
    return StreamBuilder<int>(
      stream: controller.currentIndexPage,
      builder: (context, snapshot) {
        return SizedBox(
          width: double.infinity,
          child: StepsWidget(
            lengthStepsGenerated: lengthStepsGenerated,
            selectedIndex: snapshot.data ?? 0,
          ),
        );
      },
    );
  }

  Widget _headerTitle() {
    return Padding(
      padding: Paddings.bodyHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            Strings.headerTipsOfMariaText,
            style: TextStyles.modalConfirmOrderTitleStyle.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          _dollarQuotation(),
        ],
      ),
    );
  }

  Widget _dollarQuotation() {
    return StreamBuilder<QuotationState>(
      stream: controller.quotationStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is QuotationSucessState) {
          return Container(
            alignment: Alignment.center,
            constraints: Sizes.dollarConstraints,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _dollarQuotyationText(states.quotation),
            decoration: Decorations.stepsDecoration(
              true,
              primary: AppColors.alertGreenColor.withOpacity(0.2),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _dollarQuotyationText(Quotation quote) {
    return AutoSizeText(
      Strings.dollarQuotationText(quote.formattedDollarMoney),
      style: TextStyles.orderHeaderPhotoAttached.copyWith(
        color: AppColors.alertGreenColor,
      ),
    );
  }

  Widget _carrouselImages(MariaTipsList tips) {
    return CarrouselComponent(
      tips: tips,
      onPageChanged: controller.onChangeStepsIndex,
    );
  }

  Widget _moreTips({
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: Paddings.bodyHorizontal,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            AutoSizeText(
              Strings.headerMoreTipsText,
              style: TextStyles.headerMoreTips,
            ),
            HorizontalSpacing(4),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
