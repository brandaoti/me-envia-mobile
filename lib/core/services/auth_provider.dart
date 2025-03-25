import '../models/models.dart';
import '../repositories/repositories.dart';

enum AuthType { authorized, unauthorized }

abstract class AuthProvider {
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveToken(String token);

  Future<User?> getUser();
  Future<void> deleteUser();
  Future<void> setUser(User newUser);

  Future<AuthType> getAuthType();

  Future<bool> getisFirstTimeBoardingTheApp();
  Future<void> saveisFirstTimeBoardingTheApp(bool value);
}

class AuthProviderImpl extends AuthProvider {
  User? _user;
  String? _token;
  bool? _isFirstTimeBoardingTheApp;

  final PrefsDataSource prefs;

  AuthProviderImpl({
    required this.prefs,
  });

  @override
  Future<AuthType> getAuthType() async {
    final String? token = await getToken();
    return token != null ? AuthType.authorized : AuthType.unauthorized;
  }

  @override
  Future<String?> getToken() async {
    try {
      _token ??= await prefs.getToken();
      return _token;
    } catch (e) {
      print('AuthProvider Error: $e');
      return '';
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      _token = token;

      await prefs.saveToken(token);
    } catch (e) {
      print('AuthProvider Error: $e');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      _token = null;

      await prefs.deleteToken();
    } catch (e) {
      print('AuthProvider Error: $e');
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      _user ??= await prefs.getUser();
      return _user;
    } catch (e) {
      print('UserProvider Error: $e');
      return null;
    }
  }

  @override
  Future<void> setUser(User newUser) async {
    try {
      _user = newUser;
      await prefs.createUser(newUser);
    } catch (e) {
      print('UserProvider Error: $e');
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      _user = null;
      await prefs.deleteUser();
    } catch (e) {
      print('UserProvider Error: $e');
    }
  }

  @override
  Future<bool> getisFirstTimeBoardingTheApp() async {
    try {
      _isFirstTimeBoardingTheApp ??= await prefs.getFirstTimeBoardingTheApp();
      return _isFirstTimeBoardingTheApp ?? true;
    } catch (e) {
      print('AuthProvider Error: $e');
      return false;
    }
  }

  @override
  Future<void> saveisFirstTimeBoardingTheApp(bool value) async {
    try {
      _isFirstTimeBoardingTheApp = value;

      await prefs.saveFirstTimeBoardingTheApp(value);
    } catch (e) {
      print('AuthProvider Error: $e');
    }
  }
}
