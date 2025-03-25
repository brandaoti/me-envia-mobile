import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

import 'tutorial_constants.dart';
import 'tutorial.dart';
import 'types/types.dart';

class TutorialScreen extends StatefulWidget {
  final bool? isFirstTimeBoardingTheApp;

  const TutorialScreen({
    Key? key,
    this.isFirstTimeBoardingTheApp = true,
  }) : super(key: key);

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final _pageController = PageController();
  final _controller = Modular.get<TutorialController>();

  bool get isFirstTimeBoardingTheApp =>
      widget.isFirstTimeBoardingTheApp ?? false;

  @override
  void initState() {
    _startLisneter();
    super.initState();
  }

  void _startLisneter() {
    _controller.currentIndexPage.listen((selectedIndex) {
      final tutorialState = _controller.getTutorialStateValue;

      _showModalServiceFeesWithTutorialState(
        index: selectedIndex,
        state: tutorialState,
      );
      _showModalTaxationWarningWithTutorialState(
        index: selectedIndex,
        state: tutorialState,
      );
    });
  }

  void _showModalServiceFeesWithTutorialState({
    required int index,
    required TutorialState state,
  }) {
    if (index == 1 && state == TutorialState.serviceFeePending) {
      _showModalServiceFees(
        onClosing: () => _controller.onChangeTutorialState(
          TutorialState.taxationWarningPending,
        ),
      );
    }
  }

  void _showModalTaxationWarningWithTutorialState({
    required int index,
    required TutorialState state,
  }) {
    final isLastIndex = index == (toturialItemsModel.length - 1);
    if (isLastIndex && state == TutorialState.taxationWarningPending) {
      _showModalTaxationWarning(
        onClosing: () => _controller.onChangeTutorialState(
          TutorialState.statesConfirmed,
        ),
      );
    }
  }

  void _showModalServiceFees({VoidCallback? onClosing}) {
    TutorialModalServiceFees(
      context: context,
      onClosing: onClosing,
    ).show();
  }

  void _showModalTaxationWarning({VoidCallback? onClosing}) {
    TutorialModalTaxationWarning(
      context: context,
      onClosing: onClosing,
    ).show();
  }

  void _handleOnFinishTutorial() async {
    final tutorialState = _controller.getTutorialStateValue;
    if (tutorialState == TutorialState.statesConfirmed) return;

    _showModalServiceFees(onClosing: _handleNavigateToTabScreen);
  }

  void _handleNavigateToTabScreen() {
    _controller.onChangeTutorialState(TutorialState.statesConfirmed);

    _showModalTaxationWarning(onClosing: () {
      _controller.onChangeTutorialState(TutorialState.taxationWarningPending);
      _controller.navigateToTabScreen(isFirstTimeBoardingTheApp);
    });
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      curve: Curves.easeInOut,
      duration: Durations.transition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  AppBar? _appBar() {
    if (isFirstTimeBoardingTheApp) {
      return null;
    }

    return AppBar(
      leading: BackButton(
        color: AppColors.black,
        onPressed: () => _controller.navigateToTabScreen(
          isFirstTimeBoardingTheApp,
        ),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<TutorialSectionType>(
      stream: _controller.tutorialSectionStream,
      builder: (context, snapshot) {
        final tutorialSectionType =
            snapshot.data ?? TutorialSectionType.initial;

        return Visibility(
          child: _initialSection(),
          replacement: _listOfTutorial(),
          visible: tutorialSectionType == TutorialSectionType.initial,
        );
      },
    );
  }

  Widget _initialSection() {
    return Center(
      child: Padding(
        padding: Paddings.horizontal,
        child: TutorialInitial(
          onJumpTutorial: _handleOnFinishTutorial,
          onStartTutorial: () => _controller.onChangeTutorialSectionType(
            TutorialSectionType.steps,
          ),
        ),
      ),
    );
  }

  Widget _listOfTutorial() {
    return StreamBuilder<int>(
      stream: _controller.currentIndexPage,
      builder: (context, snapshot) => ListOfTutorial(
        pageController: _pageController,
        selectedIndex: snapshot.data ?? 0,
        onPageChanged: _controller.onChangeTutorialStepsIndex,
        onFinishTutorial: () => _controller.navigateToTabScreen(
          isFirstTimeBoardingTheApp,
        ),
        onJumpTutorial: () {
          _animateToPage(toturialItemsModel.length);
          _handleOnFinishTutorial();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
