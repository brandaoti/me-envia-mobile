import 'package:rxdart/rxdart.dart';

import '../../core/repositories/repositories.dart';
import '../../core/client/client.dart';
import '../../core/models/models.dart';

import 'models/models.dart';
import 'states/registration_state.dart';

abstract class RegistrationController {
  Stream<int> get progressRegistrationStream;
  Stream<RegistrationState> get registrationStateStream;

  void onChangeProgressRegistration(int newValue);
  Future<void> handleRegistrationNewUser({
    required UserInformation userInformation,
    required AddressInformation addressInformation,
  });

  void dispose();
}

class RegistrationControllerImpl implements RegistrationController {
  final AuthRepository authRepository;

  RegistrationControllerImpl({
    required this.authRepository,
  });

  final _progressRegistrationSubject = BehaviorSubject<int>.seeded(0);
  final _registrationStateSubject = BehaviorSubject<RegistrationState>();

  @override
  Stream<int> get progressRegistrationStream =>
      _progressRegistrationSubject.stream.distinct();

  @override
  Stream<RegistrationState> get registrationStateStream =>
      _registrationStateSubject.stream.distinct();

  void onChangeRegistrationState(RegistrationState newState) {
    if (!_registrationStateSubject.isClosed) {
      _registrationStateSubject.add(newState);
    }
  }

  @override
  void onChangeProgressRegistration(int newValue) {
    if (!_progressRegistrationSubject.isClosed) {
      _progressRegistrationSubject.add(newValue);
    }
  }

  @override
  Future<void> handleRegistrationNewUser({
    required UserInformation userInformation,
    required AddressInformation addressInformation,
  }) async {
    onChangeRegistrationState(RegistrationLoadingState());

    try {
      final newUser = CreateNewUser.fromApi(
        userInformation,
        addressInformation,
      );

      await authRepository.createUser(newUser);
      onChangeRegistrationState(RegistrationSuccessState());
    } on ApiClientError catch (e) {
      onChangeRegistrationState(RegistrationErrorState(
        message: e.message,
      ));
    }
  }

  @override
  void dispose() {
    _registrationStateSubject.close();
    _progressRegistrationSubject.close();
  }
}
