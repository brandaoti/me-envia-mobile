import 'package:flutter_modular/flutter_modular.dart';

import '../client/client.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';
import '../services/auth_provider.dart';
import '../services/notification_service.dart';
import '../types/types.dart';

enum AuthType { authorized, unauthorized }

abstract class AuthController {
  Future<void> init();
  Future<bool> get isAuthorized;

  Future<User?> getUser();
  Future<String?> getToken();
  Future<AuthType> getAuthType();

  Future<void> saveUser(User newUser);
  Future<void> saveToken(String token);

  Future<bool> getisFirstTimeBoardingTheApp();

  Future<void> logout();
}

class AuthControllerImpl implements AuthController {
  final AuthProvider authProvider;
  final AuthRepository repository;
  final PushNotificationService service;

  const AuthControllerImpl({
    required this.authProvider,
    required this.repository,
    required this.service,
  });

  @override
  Future<void> init() async {
    final token = await getToken();
    if (token == null) return;

    addTokenToHeader(token);
    await setupUser();

    await service.initialize();
  }

  @override
  Future<bool> get isAuthorized async {
    return await getAuthType() == AuthType.authorized;
  }

  @override
  Future<AuthType> getAuthType() async {
    final token = await getToken();

    if (token != null) {
      return AuthType.authorized;
    }

    return AuthType.unauthorized;
  }

  Future<void> setupUser() async {
    final user = await authProvider.getUser();
    if (user == null) {
      final newUser = await _getUserApi();
      await authProvider.setUser(newUser!);
    }
  }

  void addTokenToHeader(String token) {
    Modular.get<ApiClient>().addHeader('authorization', 'Bearer $token');
  }

  @override
  Future<String?> getToken() async {
    return await authProvider.getToken();
  }

  @override
  Future<void> saveToken(String token) async {
    await authProvider.saveToken(token);
    init();
  }

  @override
  Future<void> saveUser(User newUser) async {
    await authProvider.setUser(newUser);
    init();
  }

  @override
  Future<User?> getUser() async {
    return await authProvider.getUser();
  }

  Future<User?> _getUserApi() async {
    try {
      final user = await repository.getUser();
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<bool> getisFirstTimeBoardingTheApp() async {
    return await authProvider.getisFirstTimeBoardingTheApp();
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      authProvider.deleteToken(),
      authProvider.deleteUser(),
    ]);

    Modular.to.pushReplacementNamed(RoutesName.login.name);
  }
}
