import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/network_connection.dart';
import '../../core/services/auth_provider.dart';
import '../../core/types/routes_name.dart';

abstract class SplashController {
  void init();

  Future<bool> get isConnected;
  Future<void> loadFirstTimeBoardingTheApp();
}

class SplashControllerImpl implements SplashController {
  final AuthProvider authProvider;
  final NetworkConnection connection;

  const SplashControllerImpl({
    required this.connection,
    required this.authProvider,
  });

  @override
  Future<bool> get isConnected async {
    return await connection.isConnected;
  }

  @override
  void init() async {
    if (await isConnected) {
      await loadFirstTimeBoardingTheApp();
    } else {
      navigateToNoConnectionScreen();
    }
  }

  void navigateToNoConnectionScreen() {
    Modular.to.pushReplacementNamed(RoutesName.noConnection.name);
  }

  @override
  Future<void> loadFirstTimeBoardingTheApp() async {
    final isFirstTimeBoardingTheApp =
        await authProvider.getisFirstTimeBoardingTheApp();

    if (isFirstTimeBoardingTheApp) {
      Modular.to.pushNamed(RoutesName.onboarding.name);
    } else {
      await loadRegisteredUser();
    }
  }

  Future<void> loadRegisteredUser() async {
    final authTypeMapping = {
      AuthType.authorized: RoutesName.mantras.name,
      AuthType.unauthorized: RoutesName.login.name,
    };

    final authType = await authProvider.getAuthType();
    Modular.to.popAndPushNamed(authTypeMapping[authType]!);
  }
}
