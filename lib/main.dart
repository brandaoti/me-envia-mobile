import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await EnvironmentConfig.configure();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const MariaMeEnvia(),
    ),
  );
}
