import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/services/auth_provider.dart';
import '../../core/types/types.dart';
import 'types/types.dart';

abstract class TutorialController {
  Stream<int> get currentIndexPage;
  Stream<TutorialState> get tutorialStateStream;
  Stream<TutorialSectionType> get tutorialSectionStream;

  void onChangeTutorialStepsIndex(int index);
  void onChangeTutorialSectionType(TutorialSectionType newValue);

  void onChangeTutorialState(TutorialState newValue);

  TutorialState get getTutorialStateValue;

  void navigateToTutorialSteps();
  void navigateToTabScreen(bool isFirstTimeBoardingTheApp);

  void dispose();
}

class TutorialControllerImpl implements TutorialController {
  final AuthProvider authProvider;

  TutorialControllerImpl({
    required this.authProvider,
  });

  final _stepsIndexSubject = BehaviorSubject<int>.seeded(
    0,
  );

  final _tutorialSectionSubject = BehaviorSubject<TutorialSectionType>.seeded(
    TutorialSectionType.initial,
  );

  final _tutorialStateSubject = BehaviorSubject<TutorialState>.seeded(
    TutorialState.serviceFeePending,
  );

  @override
  Stream<TutorialSectionType> get tutorialSectionStream =>
      _tutorialSectionSubject.stream.distinct();

  @override
  Stream<int> get currentIndexPage => _stepsIndexSubject.stream.distinct();

  @override
  Stream<TutorialState> get tutorialStateStream =>
      _tutorialStateSubject.stream.distinct();

  @override
  TutorialState get getTutorialStateValue {
    final value = _tutorialStateSubject.valueOrNull;
    return value ?? TutorialState.serviceFeePending;
  }

  @override
  void onChangeTutorialSectionType(TutorialSectionType newValue) {
    if (!_tutorialSectionSubject.isClosed) {
      _tutorialSectionSubject.add(newValue);
    }
  }

  @override
  void onChangeTutorialStepsIndex(int index) {
    if (!_stepsIndexSubject.isClosed) {
      _stepsIndexSubject.add(index);
    }
  }

  @override
  void onChangeTutorialState(TutorialState newValue) {
    if (!_tutorialStateSubject.isClosed) {
      _tutorialStateSubject.add(newValue);
    }
  }

  @override
  void navigateToTutorialSteps() {
    Modular.to.pushNamed(RoutesName.tutorialSteps.name);
  }

  @override
  void navigateToTabScreen(bool isFirstTimeBoardingTheApp) async {
    await authProvider.saveisFirstTimeBoardingTheApp(false);

    if (isFirstTimeBoardingTheApp) {
      Modular.to.pushNamedAndRemoveUntil(
        RoutesName.tabs.name,
        ModalRoute.withName(RoutesName.tabs.name),
      );
    } else {
      Modular.to.pushNamed(RoutesName.tabs.name);
    }
  }

  @override
  void dispose() {
    _stepsIndexSubject.close();
    _tutorialStateSubject.close();
    _tutorialSectionSubject.close();
  }
}
