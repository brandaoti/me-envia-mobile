import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../tutorial_constants.dart';
import 'components.dart';

class ListOfTutorial extends StatelessWidget {
  final int selectedIndex;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  final VoidCallback onJumpTutorial;
  final VoidCallback onFinishTutorial;

  const ListOfTutorial({
    Key? key,
    required this.selectedIndex,
    required this.pageController,
    required this.onPageChanged,
    required this.onJumpTutorial,
    required this.onFinishTutorial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: double.infinity,
          height: constraints.maxHeight,
          child: _body(constraints.maxHeight),
        );
      },
    );
  }

  Widget _body(double maxHeigth) {
    return SingleChildScrollView(
      padding: Paddings.horizontal,
      child: Column(
        children: [
          _content(maxHeigth - Dimens.tutorialMaxHeight),
          _actionsButtonAndSteps(),
        ],
      ),
    );
  }

  Widget _content(double maxHeigth) {
    return Container(
      width: double.infinity,
      child: _listOfTutorial(),
      constraints: BoxConstraints(maxHeight: maxHeigth),
    );
  }

  Widget _listOfTutorial() {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: toturialItemsModel.length,
      itemBuilder: (context, index) => TutorialComponent(
        tutorialItem: toturialItemsModel[index],
      ),
    );
  }

  Widget _actionsButtonAndSteps() {
    final isLastStepItem = selectedIndex == (toturialItemsModel.length - 1);
    return Container(
      width: double.infinity,
      height: Dimens.tutorialMaxHeight,
      padding: Paddings.inputPaddingForms,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _steps(),
          _goToBuy(
            isLastStepItem,
          ),
          _actionsButtons(
            isLastStepItem,
          ),
        ],
      ),
    );
  }

  Widget _steps() {
    return StepsWidget(
      selectedIndex: selectedIndex,
      lengthStepsGenerated: toturialItemsModel.length,
    );
  }

  Widget _goToBuy(bool isLastStepItem) {
    return Visibility(
      visible: isLastStepItem,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: AutoSizeText(
          Strings.stringLastStep,
          textAlign: TextAlign.center,
          style: TextStyles.onboardinglastString,
        ),
      ),
    );
  }

  Widget _actionsButtons(bool isLastStepItem) {
    return Visibility(
      visible: isLastStepItem,
      child: _onFinishTutorialButton(),
      replacement: _jumpTutorialStepsButton(),
    );
  }

  Widget _onFinishTutorialButton() {
    return DefaultButton(
      isValid: true,
      onPressed: onFinishTutorial,
      title: Strings.onboardigLastButtonText,
    );
  }

  Widget _jumpTutorialStepsButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SkipButton(
        onPressed: onJumpTutorial,
        title: Strings.onboardingSkipButtonText,
      ),
    );
  }
}
