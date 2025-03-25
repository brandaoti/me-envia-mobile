import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/components.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/values/values.dart';
import '../../types/types.dart';
import '../components.dart';

class UserFormFields extends StatefulWidget {
  final Widget headerWidget;
  final VoidCallback onSubmitted;
  final UserFormFieldsController controller;

  const UserFormFields({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    required this.headerWidget,
  }) : super(key: key);

  @override
  _UserFormFieldsState createState() => _UserFormFieldsState();
}

class _UserFormFieldsState extends State<UserFormFields> {
  final _nameFormFields = FormFields();
  final _emailFormFields = FormFields();
  final _passwordFormFields = FormFields();
  final _passwordConfirmFormFields = FormFields();

  final _cpfFormFields = FormFields.mask(mask: '000.000.000-00');
  final _phoneFormFields = FormFields.mask(mask: '(00) 00000-0000');

  @override
  void initState() {
    _updateFormFields();
    super.initState();
  }

  void _updateFormFields() {
    final userInformation = widget.controller.getUserInformation();

    _cpfFormFields.controller?.text = userInformation.cpf ?? '';
    _nameFormFields.controller?.text = userInformation.name ?? '';
    _phoneFormFields.controller?.text = userInformation.phone ?? '';
    _emailFormFields.controller?.text = userInformation.email ?? '';
    _passwordFormFields.controller?.text = userInformation.password ?? '';
    _passwordConfirmFormFields.controller?.text =
        userInformation.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.headerWidget,
          _name(),
          _email(),
          _cpf(),
          _phone(),
          _statePasswordVisible(),
          const VerticalSpacing(40),
          _onSubmittedButton(),
          const VerticalSpacing(40),
        ],
      ),
    );
  }

  Widget _name() {
    return NameInputComponent(
      formFields: _nameFormFields,
      onChanged: (String? value) {
        widget.controller.onFormChanged(UserFormType.name, value ?? '');
      },
      onFieldSubmitted: (_) {
        _emailFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _email() {
    return EmailInputComponent(
      formFields: _emailFormFields,
      onFieldSubmitted: (_) {
        _cpfFormFields.focus?.requestFocus();
      },
      onChanged: (String? value) {
        widget.controller.onFormChanged(UserFormType.email, value ?? '');
      },
    );
  }

  Widget _cpf() {
    return CPFInputComponent(
      formFields: _cpfFormFields,
      onChanged: (String? value) {
        widget.controller.onFormChanged(UserFormType.cpf, value ?? '');
      },
      onFieldSubmitted: (_) {
        _phoneFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _phone() {
    return PhoneInputComponent(
      formFields: _phoneFormFields,
      onChanged: (String? value) {
        widget.controller.onFormChanged(UserFormType.phone, value ?? '');
      },
      onFieldSubmitted: (_) {
        _passwordFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _statePasswordVisible() {
    return StreamBuilder<bool>(
      stream: widget.controller.isPasswordVisibleStream,
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

  Widget _password(bool isPasswordVisible) {
    return PasswordInputComponent(
      obscureText: isPasswordVisible,
      formFields: _passwordFormFields,
      onChangedObscureText: widget.controller.togglePasswordVisible,
      onChanged: (value) {
        widget.controller.onFormChanged(UserFormType.password, value ?? '');
      },
      onFieldSubmitted: (_) {
        _passwordConfirmFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _passwordConfirmation(bool isPasswordVisible) {
    return PasswordInputComponent(
      obscureText: isPasswordVisible,
      textInputAction: TextInputAction.done,
      formFields: _passwordConfirmFormFields,
      labelText: Strings.passwordConfirmationInputLabelText,
      onChangedObscureText: widget.controller.togglePasswordVisible,
      onChanged: (value) {
        widget.controller
            .onFormChanged(UserFormType.confirmPassword, value ?? '');
      },
      validator: (value) {
        final password = _passwordFormFields.controller?.text;
        return Validators.confirmPassword(password, value);
      },
      onFieldSubmitted: (_) => widget.onSubmitted(),
    );
  }

  Widget _onSubmittedButton() {
    return DefaultButton(
      isValid: true,
      title: Strings.nextProgress,
      onPressed: widget.onSubmitted,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cpfFormFields.dispose();
    _nameFormFields.dispose();
    _emailFormFields.dispose();
    _phoneFormFields.dispose();
    _passwordFormFields.dispose();
    _passwordConfirmFormFields.dispose();
  }
}
