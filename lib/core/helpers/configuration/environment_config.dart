import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  late String apiBaseUrl;
  late String locationBaseUrl;
  late String viaCepApiBaseUrl;

  EnvironmentConfig._();

  static EnvironmentConfig? _instance = EnvironmentConfig._();

  factory EnvironmentConfig() {
    return _instance!;
  }

  void _setUrls({
    required String apiUrl,
    required String locationBaseUrl,
    required String viaCepApiBaseUrl,
  }) {
    _instance!.apiBaseUrl = apiUrl;
    _instance!.locationBaseUrl = locationBaseUrl;
    _instance!.viaCepApiBaseUrl = viaCepApiBaseUrl;
  }

  static Future<void> configure({
    String fileName = '.env',
  }) async {
    _instance ??= EnvironmentConfig._();

    await dotenv.load(fileName: fileName);
    final Map<String, String> loadedConfig = dotenv.env;

    _instance!._setUrls(
      apiUrl: loadedConfig['BASE_URL'] ?? '',
      viaCepApiBaseUrl: loadedConfig['VIACEP_BASE_URL'] ?? '',
      locationBaseUrl: loadedConfig['LOCATION_BASE_URL'] ?? '',
    );
  }

  @override
  String toString() =>
      'EnvironmentConfig(apiBaseUrl: $apiBaseUrl, locationBaseUrl: $locationBaseUrl, viaCepApiBaseUrl: $viaCepApiBaseUrl)';
}
