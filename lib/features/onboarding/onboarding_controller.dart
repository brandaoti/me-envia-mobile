import 'package:flutter_modular/flutter_modular.dart';

import 'package:rxdart/rxdart.dart';

import '../../core/types/types.dart';

abstract class OnboardingController {
  Stream<int> get currentIndex;

  void onChangeIndex(int index);
  void handleFinishOnboarding();

  void dispose();
}

class OnboardingControllerImpl implements OnboardingController {
  final _currentIndexSubject = BehaviorSubject.seeded(0);

  @override
  Stream<int> get currentIndex => _currentIndexSubject.stream.distinct();

  @override
  void onChangeIndex(int index) {
    if (!_currentIndexSubject.isClosed) {
      _currentIndexSubject.add(index);
    }
  }

  @override
  void handleFinishOnboarding() async {
    Modular.to.pushNamed(RoutesName.login.name);
  }

  @override
  void dispose() {
    _currentIndexSubject.close();
  }
}
