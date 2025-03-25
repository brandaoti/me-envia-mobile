import 'package:dio/dio.dart';

import '../../core.dart';

abstract class AuthRepository {
  Future<User> getUser();
  Future<User> updateUser(UpdateUser newUser);
  Future<void> updateFcmToken(UpdateToken updateToken);
  Future<Address> updateAddress(UpdateAddress newAddress);

  Future<void> forgotPassword(String email);

  Future<String> login(LoginRequest loginRequest);
  Future<CreateNewUserResponse> createUser(CreateNewUser newUser);

  Future<void> deleteAccount();
}

class AuthRepositoryImpl extends RepositoryErrorHandling
    implements AuthRepository {
  final ApiClient apiClient;

  const AuthRepositoryImpl({
    required this.apiClient,
    required NetworkConnectionService networkConnectionService,
  }) : super(networkConnectionService: networkConnectionService);

  @override
  Future<CreateNewUserResponse> createUser(CreateNewUser newUser) async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.post(
        '/users',
        data: newUser.toMap(),
      );

      return CreateNewUserResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'createUser');
    } catch (error) {
      throw Failure(message: Strings.errorUserCreationFailed);
    }
  }

  @override
  Future<String> login(LoginRequest loginRequest) async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.post(
        '/users/auth',
        data: loginRequest.toMap(),
      );

      return response.data['token'];
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'login');
    } catch (error) {
      throw Failure(message: Strings.errorUserCreationFailed);
    }
  }

  @override
  Future<User> getUser() async {
    try {
      await super.checkConnectivity();
      final response = await apiClient.instance.get('/users/me');
      return User.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getUser');
    } catch (error) {
      throw Failure(
        message: Strings.errorUserCreationFailed,
      );
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await super.checkConnectivity();

      final data = Map.from({'email': email});
      await apiClient.instance.post('/users/request-new-password', data: data);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'forgotPassword');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<User> updateUser(UpdateUser newUser) async {
    try {
      final response = await apiClient.instance.put(
        '/users',
        data: newUser.toApi(),
      );

      return User.fromJson(response.data['updatedUser']);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<void> updateFcmToken(UpdateToken updateToken) async {
    try {
      await apiClient.instance.put(
        '/users',
        data: updateToken.toApi(),
      );
    } on DioError catch (error) {
      throw super.mappingDioErrors(error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<Address> updateAddress(UpdateAddress newAddress) async {
    try {
      await apiClient.instance.put(
        '/users',
        data: newAddress.toApi(),
      );

      return Address(
        city: newAddress.city ?? '',
        state: newAddress.state ?? '',
        street: newAddress.street ?? '',
        zipcode: newAddress.zipcode ?? '',
        country: newAddress.country ?? '',
        district: newAddress.district ?? '',
        complement: newAddress.complement ?? '',
        houseNumber: newAddress.houseNumber ?? '',
      );
    } on DioError catch (error) {
      throw super.mappingDioErrors(error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await apiClient.instance.delete('/users');
    } on DioError catch (error) {
      throw super.mappingDioErrors(error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }
}
