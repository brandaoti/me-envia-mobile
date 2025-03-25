import 'package:dio/dio.dart';

import 'interceptors/custom_interceptors.dart';

class ApiClient {
  late final Dio? _dio;

  Dio get instance => _dio!;

  ApiClient({required String baseUrl}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    _dio!.interceptors.add(CustomInterceptors());
  }

  void addHeader(String key, String value) {
    _dio!.options.headers = {key: value};
  }
}
