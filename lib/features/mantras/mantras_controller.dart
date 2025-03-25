import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core.dart';

abstract class MantrasController {
  String get getCurrentMantra;

  void init();
}

class MantrasControllerImpl implements MantrasController {
  @override
  void init() async {
    await Future.delayed(Durations.splashAnimation);
    Modular.to.popAndPushNamed(RoutesName.tabs.name);
  }

  @override
  String get getCurrentMantra => Strings.randomMantrasMessage;
}
