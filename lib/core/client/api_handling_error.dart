import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core.dart';

abstract class ApiHandlingError {
  Future<void> checkConnectivity();
  ApiClientError mappingErrors(dynamic error);

  ApiClientError mappingDioErrors(DioError error, [String? endPoint]);
}

class RepositoryErrorHandling implements ApiHandlingError {
  final NetworkConnectionService _networkConnectionService;

  const RepositoryErrorHandling({
    required NetworkConnectionService networkConnectionService,
  }) : _networkConnectionService = networkConnectionService;

  @override
  Future<void> checkConnectivity() async {
    if (!(await _networkConnectionService.isConnected)) {
      throw ConnectionFailure();
    }
  }

  @override
  Failure mappingErrors(dynamic error) {
    return Failure(message: error.toString());
  }

  @override
  ApiClientError mappingDioErrors(DioError error, [String? endPoint]) {
    if (endPoint == 'login') {
      _loginMappinErrors(error);
    }

    if (endPoint == 'createUser') {
      _createUserMappinErrors(error);
    }

    if (endPoint == 'getUser') {
      _getUserMappinErrors(error);
    }

    if (endPoint == 'forgotPassword') {
      _forgotPasswordMappinErrors(error);
    }

    if (endPoint == 'getMariaTips') {
      _getMariaTipsMappinErrors(error);
    }

    if (endPoint == 'getPackages') {
      _getRequestedBoxMappinErrors(error);
    }

    if (error.response?.statusCode == 412) {
      _handleLogout();

      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }

    if (error.response?.statusCode == 500 ||
        error.response?.statusCode == 413) {
      throw Failure(
        message: Strings.errorUnknownInApi,
      );
    }

    throw Failure(
      message: error.message,
    );
  }

  void _handleLogout() async {
    await Modular.get<AuthController>().logout();
  }

  ApiClientError? _loginMappinErrors(DioError error) {
    if (error.response?.statusCode == 400) {
      throw EmailNotVerified(
        message: Strings.errorEmailNotVerified,
      );
    }

    if (error.response?.statusCode == 401) {
      throw InvalidCredentials(
        message: Strings.errorUserCreationFailed,
      );
    }
  }

  ApiClientError? _createUserMappinErrors(DioError error) {
    if (error.response?.statusCode == 400) {
      throw InvalidArgument(
        message: error.response?.data['error'] ?? error.message,
      );
    }

    if (error.response?.statusCode == 403) {
      throw AlreadyRegisteredUser(
        message: Strings.errorAlreadyRegisteredUser,
      );
    }
  }

  ApiClientError? _getUserMappinErrors(DioError error) {
    if (error.response?.statusCode == 404) {
      throw NotFoundUser(
        message: Strings.errorUserNotFound,
      );
    }
  }

  ApiClientError? _forgotPasswordMappinErrors(DioError error) {
    if (error.response?.statusCode == 400) {
      throw NotFoundUser(
        message: Strings.errorEmailNotExists,
      );
    }
  }

  ApiClientError? _getMariaTipsMappinErrors(DioError error) {
    if (error.response?.statusCode == 403) {
      throw NotAutorized(
        message: error.response?.data['error'] ?? error.message,
      );
    }
  }

  ApiClientError? _getRequestedBoxMappinErrors(DioError error) {
    if (error.response?.statusCode == 403) {
      throw NotAutorized(
        message: error.response?.data['error'] ?? error.message,
      );
    }
  }
}
