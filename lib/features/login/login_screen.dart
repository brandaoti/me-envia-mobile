import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../core/types/types.dart';

import '../../core/components/components.dart';
import '../../core/helpers/helpers.dart';
import '../../core/values/values.dart';

import 'login_controller.dart';
import 'states/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailFormFields = FormFields();
  final _passwordFormFields = FormFields();

  final _controller = Modular.get<LoginController>();

  @override
  void dispose() {
    _emailFormFields.dispose();
    _passwordFormFields.dispose();
    _formKey.currentState?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitButton() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final email = _emailFormFields.controller?.text ?? '';
    final password = _passwordFormFields.controller?.text ?? '';

    await _controller.handleSubmit(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(
      shrinkWrap: true,
      padding: Paddings.horizontal,
      children: [
        Container(
          child: _logo(),
          width: double.infinity,
          alignment: Alignment.center,
          height: context.screenHeight * 0.35,
        ),
        _sesctionBody(),
      ],
    );
  }

  Widget _sesctionBody() {
    return StreamBuilder<LoginState>(
      stream: _controller.loginStateStream,
      builder: (context, snapshot) {
        bool isLoading = false;
        String? errorMessage;
        final loginState = snapshot.data;

        if (loginState is LoginLoadingState) {
          isLoading = true;
        }

        if (loginState is LoginErrorState) {
          isLoading = false;
          errorMessage = loginState.message;
        }

        return Column(
          children: [
            _forms(!isLoading, errorMessage),
            const VerticalSpacing(38),
            _actionsButtons(isLoading),
          ],
        );
      },
    );
  }

  Widget _logo() {
    return SvgPicture.asset(
      Svgs.defaultLogo,
      height: 80,
      width: double.infinity,
    );
  }

  Widget _forms(
    bool isEnable,
    String? loginErrorMessage,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _emailForm(isEnable),
          const VerticalSpacing(16),
          _passwordForm(isEnable, loginErrorMessage),
        ],
      ),
    );
  }

  Widget _actionsButtons(bool isLoading) {
    return Column(
      children: [
        _loginBtn(isLoading),
        const VerticalSpacing(24),
        _registerBtn(!isLoading),
        const VerticalSpacing(24),
        _forgotPasswordBtn(!isLoading),
        const VerticalSpacing(24),
      ],
    );
  }

  Widget _emailForm(bool isEnable) {
    return TextFormField(
      enabled: isEnable,
      validator: Validators.email,
      focusNode: _emailFormFields.focus,
      controller: _emailFormFields.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        border: Decorations.inputBorderForms,
        labelText: Strings.emailInputLabelText,
        fillColor: const Color(0xffCBCDDE).withOpacity(0.2),
      ),
      onFieldSubmitted: (_) {
        _passwordFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _passwordForm(bool isEnable, String? errorText) {
    return StreamBuilder<bool>(
      stream: _controller.isPasswordVisibleStream,
      builder: (context, snapshot) {
        final bool isPasswordVisible = snapshot.data ?? true;
        return PasswordInputComponent(
          errorMaxLines: 3,
          isEnable: isEnable,
          errorText: errorText,
          obscureText: isPasswordVisible,
          formFields: _passwordFormFields,
          onFieldSubmitted: (_) => _handleSubmitButton(),
          onChangedObscureText: _controller.togglePasswordVisible,
        );
      },
    );
  }

  Widget _loginBtn(bool isLoading) {
    return DefaultButton(
      isValid: true,
      isLoading: isLoading,
      title: Strings.loginButtonTitle,
      onPressed: _handleSubmitButton,
    );
  }

  Widget _registerBtn(bool isEnable) {
    return RoundedButton(
      title: Strings.registerButtonTitle,
      onPressed: () => Modular.to.pushNamed(RoutesName.registration.name),
    );
  }

  Widget _forgotPasswordBtn(bool isEnable) {
    return BordLessButton(
      title: Strings.forgotPasswordButtonTitle,
      onPressed: () => Modular.to.pushNamed(RoutesName.forgotPassword.name),
    );
  }
}
