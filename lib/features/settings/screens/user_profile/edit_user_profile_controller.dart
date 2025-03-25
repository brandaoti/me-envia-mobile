import 'package:cubos_extensions/cubos_extensions.dart';
import 'package:rxdart/rxdart.dart';

import '../../../registration/registration.dart';
import '../../states/edit_user_state.dart';
import '../../../../core/core.dart';
import '../../settings.dart';

abstract class EditUserProfileController {
  Stream<bool> get isPasswordVisibleStream;
  Stream<EditUserState> get editUserStateStream;

  Future<User?> getUserInformation();

  void togglePasswordVisible(bool value);

  void onChangeForm(EditUserInfoFormType form, String value);
  void handleEditUserInformation();

  void dispose();
}

class EditUserProfileControllerImpl implements EditUserProfileController {
  final AuthRepository repository;
  final AuthController authController;

  EditUserProfileControllerImpl({
    required this.repository,
    required this.authController,
  });

  final UserInformation _editUserInformation = UserInformation();

  final _editUserStateSubject = BehaviorSubject<EditUserState>();
  final _isPasswordVisibleSubject = BehaviorSubject<bool>.seeded(true);

  @override
  Stream<bool> get isPasswordVisibleStream =>
      _isPasswordVisibleSubject.stream.distinct();

  @override
  Stream<EditUserState> get editUserStateStream =>
      _editUserStateSubject.stream.distinct();

  @override
  Future<User?> getUserInformation() async {
    final user = await authController.getUser();
    return user;
  }

  @override
  void onChangeForm(EditUserInfoFormType form, String value) {
    switch (form) {
      case EditUserInfoFormType.name:
        _editUserInformation.name = value;
        break;
      case EditUserInfoFormType.cpf:
        _editUserInformation.cpf = value;
        break;
      case EditUserInfoFormType.phone:
        _editUserInformation.phone = _setPhone(value);
        break;
      case EditUserInfoFormType.password:
        _editUserInformation.password = value;
        break;
    }
  }

  String _setPhone(String? value) {
    if (value != null && value.length <= 15) {
      return value;
    }

    return _editUserInformation.phone ?? '';
  }

  @override
  void togglePasswordVisible(bool value) {
    if (!_isPasswordVisibleSubject.isClosed) {
      _isPasswordVisibleSubject.add(value);
    }
  }

  void onChangeEditUserState(EditUserState newState) {
    if (!_editUserStateSubject.isClosed) {
      _editUserStateSubject.add(newState);
    }
  }

  void handleSucessUpdate(User newUser) async {
    final currentUser = await authController.getUser();
    if (currentUser != null) {
      await authController.saveUser(currentUser.copyWith(
        id: newUser.id,
        cpf: newUser.cpf,
        type: newUser.type,
        name: newUser.name,
        email: newUser.email,
        phoneNumber: newUser.phoneNumber,
      ));
    }
  }

  @override
  void handleEditUserInformation() async {
    onChangeEditUserState(const EditUserLoadingState());

    if (_editUserInformation.notContaisInformation) {
      onChangeEditUserState(const EditUserErrorState(
        message: Strings.noUserInformationToUptade,
      ));
      return;
    }

    try {
      final userInfo = UpdateUser(
        name: _editUserInformation.name,
        password: _editUserInformation.password,
        phoneNumber: _editUserInformation.phone.cleanPhone,
      );

      final newUser = await repository.updateUser(userInfo);
      handleSucessUpdate(newUser);

      onChangeEditUserState(const EditUserSuccessState());
    } on ApiClientError catch (e) {
      onChangeEditUserState(EditUserErrorState(
        message: e.message,
      ));
    }
  }

  @override
  void dispose() {
    _editUserStateSubject.close();
    _isPasswordVisibleSubject.close();
  }
}
