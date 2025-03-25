import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core.dart';
import 'components/onboarding_component.dart';
import 'model/onboarding_item.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  final _controller = Modular.get<OnboardingController>();

  final List<OnBoardingItem> _onboardingItens = [
    const OnBoardingItem(
      title: Strings.titleFirstStep,
      assetName: Svgs.onBoarding1,
      subtitle: Strings.subtitleFirstStep,
    ),
    const OnBoardingItem(
      title: Strings.titleSecondStep,
      assetName: Svgs.onBoarding2,
      subtitle: Strings.subtitleSecondStep,
    ),
    const OnBoardingItem(
      title: Strings.titleThirdStep,
      assetName: Svgs.onBoarding3,
      subtitle: Strings.subtitleThirdStep,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onChangePage(int index) {
    _controller.onChangeIndex(index);
  }

  void _skipToBottomOfpage() {
    _pageController.animateToPage(
      2,
      curve: Curves.easeInOut,
      duration: Durations.transition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: Paddings.bodyHorizontal,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: _listOfItems(),
          ),
          _sectionBottom(),
        ],
      ),
    );
  }

  Widget _listOfItems() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onChangePage,
      scrollDirection: Axis.horizontal,
      itemCount: _onboardingItens.length,
      itemBuilder: (_, index) => OnBoardingComponent(
        onBoardingItem: _onboardingItens[index],
      ),
    );
  }

  Widget _sectionBottom() {
    return StreamBuilder<int>(
      stream: _controller.currentIndex,
      builder: (context, snapshot) {
        final int currentIndex = snapshot.data ?? 0;
        return Container(
          height: 168,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _steps(currentIndex),
              _lastStepText(currentIndex),
              _actionsButton(currentIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _steps(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(_onboardingItens.length, (int index) {
        return _stepsAnimated(index == currentIndex);
      }),
    );
  }

  Widget _stepsAnimated(bool isActive) {
    return AnimatedContainer(
      height: 8,
      width: isActive ? 27 : 8,
      duration: Durations.transition,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: Decorations.stepsDecoration(isActive),
    );
  }

  Widget _lastStepText(int currentIndex) {
    return Visibility(
      visible: currentIndex == 2,
      child: const AutoSizeText(
        Strings.stringLastStep,
        textAlign: TextAlign.left,
        style: TextStyles.onboardinglastString,
      ),
    );
  }

  Widget _actionsButton(int currentIndex) {
    return Visibility(
      child: _skipButton(),
      visible: currentIndex < 2,
      replacement: _defaultButton(),
    );
  }

  Widget _defaultButton() {
    return DefaultButton(
      isValid: true,
      title: Strings.onboardigLastButtonText,
      onPressed: _controller.handleFinishOnboarding,
    );
  }

  Widget _skipButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: SkipButton(
        onPressed: _skipToBottomOfpage,
        title: Strings.onboardingSkipButtonText,
      ),
    );
  }
}
