import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/components/components.dart';
import '../../core/helpers/helpers.dart';
import '../../core/values/values.dart';
import 'forgot_password_controller.dart';
import 'states/forgot_password_states.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailFormFields = FormFields();
  final _pageController = PageController();

  final _controller = Modular.get<ForgotPasswordController>();

  @override
  void initState() {
    _startListener();
    super.initState();
  }

  void _startListener() {
    _controller.forgotPasswordStateStream.listen((states) {
      if (states is ForgotPasswordSucessState) {
        _animateToSenEmailPage();
      }
    });
  }

  void _handleSendEmailToChangePassword() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final email = _emailFormFields.getText;
      await _controller.handleSendEmail(email!);
    }
  }

  void _animateToSenEmailPage() async {
    _pageController.animateToPage(
      1,
      curve: Curves.easeInOut,
      duration: Durations.transition,
    );

    await Future.delayed(Durations.transitionToNavigate);
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _body(),
        ),
      ),
    );
  }

  Widget _backButton() {
    return const Positioned(
      top: 20,
      left: 12,
      child: BackButton(color: AppColors.secondary),
    );
  }

  Widget _body() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: _pageBuilder(),
        ),
        _backButton()
      ],
    );
  }

  Widget _pageBuilder() {
    return Padding(
      padding: Paddings.horizontal,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(child: _sectionInsertEmail()),
          _sectionSendEmail(),
        ],
      ),
    );
  }

  Widget _sectionInsertEmail() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: _sectionInsertEmailWidget(),
      ),
    );
  }

  Widget _sectionInsertEmailWidget() {
    return StreamBuilder<ForgotPasswordState>(
      stream: _controller.forgotPasswordStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final forgotPasswordStates = snapshot.data;

        if (forgotPasswordStates is ForgotPasswordErrorState) {
          errorText = forgotPasswordStates.message;
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpacing(70),
            _illustrations(Svgs.forgotPassword01, height: 300, width: 300),
            const VerticalSpacing(48),
            _text(text: Strings.retrieveYourPasswordText),
            const VerticalSpacing(32),
            _email(
              errorText: errorText,
              isEnabled: forgotPasswordStates is! ForgotPasswordLoadingState,
            ),
            _buttonSendEmail(
              isLoading: forgotPasswordStates is ForgotPasswordLoadingState,
            ),
          ],
        );
      },
    );
  }

  Widget _email({
    String? errorText,
    bool isEnabled = true,
  }) {
    return TextFormField(
      enabled: isEnabled,
      textAlign: TextAlign.start,
      validator: Validators.email,
      textDirection: TextDirection.ltr,
      focusNode: _emailFormFields.focus,
      controller: _emailFormFields.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorText: errorText,
        labelText: Strings.emailInputLabelText,
        helperText: Strings.forgotPasswordInputHelperText,
      ),
      onFieldSubmitted: (_) => _handleSendEmailToChangePassword(),
    );
  }

  Widget _buttonSendEmail({
    required bool isLoading,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: DefaultButton(
        isValid: true,
        isLoading: isLoading,
        onPressed: _handleSendEmailToChangePassword,
        title: Strings.forgotPasswordButtonTitleSend,
      ),
    );
  }

  Widget _sectionSendEmail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _illustrations(Svgs.forgotPassword02),
        const VerticalSpacing(60),
        _text(),
        const VerticalSpacing(16),
        _text(
          style: TextStyles.forgotPasswordContent,
          text: Strings.retrieveYourPasswordContentText,
        ),
      ],
    );
  }

  Widget _illustrations(String svgPath, {double? height, double? width}) {
    return SvgPicture.asset(
      svgPath,
      height: height,
      width: width,
    );
  }

  Widget _text({
    TextStyle style = TextStyles.forgotPasswordTitles,
    String text = Strings.retrieveYourPasswordEmailTitleText,
  }) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    _emailFormFields.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
