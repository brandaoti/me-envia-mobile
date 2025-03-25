import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/core.dart';

import '../../states/edit_user_state.dart';
import '../../settings.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();

  final _nameFormFields = FormFields();
  final _emailFormFields = FormFields();
  final _passwordFormFields = FormFields();
  final _passwordConfirmFormFields = FormFields();

  final _cpfFormFields = FormFields.mask(mask: '000.000.000-00');
  final _phoneFormFields = FormFields.mask(mask: '(00) 00000-0000');

  final _controller = Modular.get<EditUserProfileController>();

  @override
  void initState() {
    _startListerner();
    _updateFormFields();
    super.initState();
  }

  void _updateFormFields() async {
    final user = await _controller.getUserInformation();

    if (user != null) {
      _cpfFormFields.updateText(user.cpf);
      _nameFormFields.updateText(user.name);
      _emailFormFields.updateText(user.email);
      _phoneFormFields.updateText(user.phoneNumber);
    }
  }

  void _startListerner() {
    _controller.editUserStateStream.listen((states) {
      if (states is EditUserSuccessState) {
        _animateToPage(1);
        _navigateToHomeScreen();
      }
    });
  }

  void _handleEditUserInformation() {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      _controller.handleEditUserInformation();
    }
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.easeIn,
      duration: Durations.transition,
    );
  }

  void _navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: _appBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: const BackButton(color: AppColors.black),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Center(
        child: Padding(
          child: _pageBuilder(),
          padding: Paddings.bodyHorizontal,
        ),
      ),
    );
  }

  Widget _pageBuilder() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _inputsColumn(),
        const EditDone(),
      ],
    );
  }

  Widget _inputsColumn() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _title(),
            const VerticalSpacing(60),
            _name(),
            _email(),
            _cpf(),
            _phone(),
            _statePasswordVisible(),
            const VerticalSpacing(32),
            _nextPage(),
            const VerticalSpacing(35),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.editProfileTitle,
      textAlign: TextAlign.center,
      style: TextStyles.bodyEditingProfileStyle,
    );
  }

  Widget _name() {
    return NameInputComponent(
      formFields: _nameFormFields,
      onChanged: (value) {
        _controller.onChangeForm(EditUserInfoFormType.name, value ?? '');
      },
      onFieldSubmitted: (_) {
        _phoneFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _email() {
    return EmailInputComponent(
      enabled: false,
      validator: null,
      formFields: _emailFormFields,
    );
  }

  Widget _cpf() {
    return CPFInputComponent(
      enabled: false,
      validator: null,
      formFields: _cpfFormFields,
    );
  }

  Widget _phone() {
    return PhoneInputComponent(
      formFields: _phoneFormFields,
      onChanged: (value) {
        _controller.onChangeForm(
          EditUserInfoFormType.phone,
          value ?? '',
        );
      },
      onFieldSubmitted: (_) {
        _passwordFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _statePasswordVisible() {
    return StreamBuilder<bool>(
      stream: _controller.isPasswordVisibleStream,
      builder: (context, snapshot) {
        final bool isPasswordVisible = snapshot.data ?? true;
        return Column(
          children: [
            _password(isPasswordVisible),
            _passwordConfirmation(isPasswordVisible),
          ],
        );
      },
    );
  }

  Widget _password(bool obscureText) {
    return PasswordInputComponent(
      obscureText: obscureText,
      labelText: Strings.newPasswordInputLabelText,
      formFields: _passwordFormFields,
      onChangedObscureText: _controller.togglePasswordVisible,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return Validators.password(value);
        }
        return null;
      },
      onChanged: (value) {
        _controller.onChangeForm(
          EditUserInfoFormType.password,
          value ?? '',
        );
      },
      onFieldSubmitted: (_) {
        _passwordConfirmFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _passwordConfirmation(bool obscureText) {
    return StreamBuilder<EditUserState>(
      stream: _controller.editUserStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final states = snapshot.data;

        if (states is EditUserErrorState) {
          errorText = states.message;
        }

        return PasswordInputComponent(
          errorText: errorText,
          obscureText: obscureText,
          formFields: _passwordConfirmFormFields,
          onFieldSubmitted: (_) => _handleEditUserInformation(),
          onChangedObscureText: _controller.togglePasswordVisible,
          labelText: Strings.newPasswordConfirmationInputLabelText,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final password = _passwordFormFields.controller?.text;
              return Validators.confirmPassword(password, value);
            }

            return null;
          },
        );
      },
    );
  }

  Widget _nextPage() {
    return StreamBuilder<EditUserState>(
      stream: _controller.editUserStateStream,
      builder: (context, snapshot) {
        return DefaultButton(
          title: Strings.nextProgress,
          isValid: true,
          onPressed: _handleEditUserInformation,
          isLoading: snapshot.data is EditUserLoadingState,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameFormFields.dispose();
    _cpfFormFields.dispose();
    _phoneFormFields.dispose();
    _pageController.dispose();
    _passwordFormFields.dispose();
    _passwordConfirmFormFields.dispose();
  }
}
