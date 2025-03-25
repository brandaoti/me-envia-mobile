import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';
import 'prefs_data_source_keys.dart';

abstract class PrefsDataSource {
  Future<User?> getUser();
  Future<void> deleteUser();
  Future<void> createUser(User user);

  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveToken(String token);

  Future<bool> getFirstTimeBoardingTheApp();
  Future<void> saveFirstTimeBoardingTheApp(bool value);
}

class PrefsDataSourceImpl implements PrefsDataSource {
  late Future<SharedPreferences> _sharedPreferences;

  PrefsDataSourceImpl() {
    _sharedPreferences = SharedPreferences.getInstance();
  }

  @override
  Future<String?> getToken() async {
    final instance = await _sharedPreferences;

    try {
      if (!instance.containsKey(PreferencesDataSourceKeys.tokenJWTKey)) {
        return null;
      }

      final String? token = instance.getString(
        PreferencesDataSourceKeys.tokenJWTKey,
      );
      return token;
    } catch (e) {
      print('PrefsDataSource GetAuthError: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    final instance = await _sharedPreferences;

    try {
      await instance.setString(PreferencesDataSourceKeys.tokenJWTKey, token);
    } catch (e) {
      print('PrefsDataSource saveTokenError: ${e.toString()}');
      throw e.toString();
    }
  }

  @override
  Future<User?> getUser() async {
    final instance = await _sharedPreferences;

    try {
      if (!instance.containsKey(PreferencesDataSourceKeys.userKey)) {
        return null;
      }

      final String? json = instance.getString(
        PreferencesDataSourceKeys.userKey,
      );
      return User.fromInternalData(jsonDecode(json!));
    } catch (e) {
      print('PrefsDataSource GetUserError: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<void> createUser(User user) async {
    final instance = await _sharedPreferences;

    try {
      final json = jsonEncode(user.toMap());

      await instance.setString(PreferencesDataSourceKeys.userKey, json);
    } catch (e) {
      print('PrefsDataSource createUserError: ${e.toString()}');
      throw e.toString();
    }
  }

  @override
  Future<void> deleteUser() async {
    final instance = await _sharedPreferences;

    try {
      if (instance.containsKey(PreferencesDataSourceKeys.userKey)) {
        await instance.remove(PreferencesDataSourceKeys.userKey);
      }
    } catch (e) {
      print('PrefsDataSource deleteUserError: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteToken() async {
    final instance = await _sharedPreferences;

    try {
      if (instance.containsKey(PreferencesDataSourceKeys.tokenJWTKey)) {
        await instance.remove(PreferencesDataSourceKeys.tokenJWTKey);
      }
    } catch (e) {
      print('PrefsDataSource deleteTokenError: ${e.toString()}');
    }
  }

  @override
  Future<bool> getFirstTimeBoardingTheApp() async {
    final instance = await _sharedPreferences;

    try {
      final firstTimeBoardingTheApp = instance.getBool(
        PreferencesDataSourceKeys.firstTimeBoardingTheApp,
      );
      return firstTimeBoardingTheApp ?? true;
    } catch (e) {
      print('PrefsDataSource GetFirstTimeBoardingTheApp: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<void> saveFirstTimeBoardingTheApp(bool value) async {
    final instance = await _sharedPreferences;

    try {
      await instance.setBool(
        PreferencesDataSourceKeys.firstTimeBoardingTheApp,
        value,
      );
    } catch (e) {
      print('PrefsDataSource SaveFirstTimeBoardingTheApp: ${e.toString()}');
      throw e.toString();
    }
  }
}
