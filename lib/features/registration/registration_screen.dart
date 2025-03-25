import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../core/components/components.dart';
import '../../core/types/types.dart';
import '../../core/values/values.dart';
import '../features.dart';

import 'registration_controller.dart';
import 'states/registration_state.dart';
import 'registration.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController(initialPage: 0);

  late final RegistrationController _controller;
  late final TermOfUseController _termOfUseController;
  late final AddressFormController _addresFieldsController;
  late final UserFormFieldsController _userInformationController;

  @override
  void initState() {
    _controller = Modular.get<RegistrationController>();
    _termOfUseController = Modular.get<TermOfUseController>();
    _userInformationController = Modular.get<UserFormFieldsController>();
    _addresFieldsController = Modular.get<AddressFormController>()..init();

    _startListerner();
    super.initState();
  }

  void _startListerner() {
    _controller.registrationStateStream.listen((states) {
      if (states is RegistrationSuccessState) {
        _animateToPage(3);
        _navigateToLoginScreen();
      }

      if (states is RegistrationErrorState) {
        _showModalToRegistrationErrorState(states.message);
      }
    });
  }

  void _showModalToRegistrationErrorState(String? message) {
    return ActionToErrorState(
      message: message,
      context: context,
    ).show();
  }

  void _navigateToLoginScreen() async {
    await Future.delayed(Durations.transitionToNavigate);
    Modular.to.pushNamed(RoutesName.login.name);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controller.dispose();
    _formKey.currentState?.dispose();
    _userInformationController.dispose();
    _addresFieldsController.dispose();
    _termOfUseController.dispose();
  }

  bool _validatesFields() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _onSubmittedUserFormFields() {
    final bool isValid = _validatesFields();

    if (isValid) {
      _animateToPage(1);
      _controller.onChangeProgressRegistration(1);
    }
  }

  void _onSubmittedAddressFormFields() {
    final bool isValid = _validatesFields();

    if (isValid) {
      _animateToPage(2);
      _controller.onChangeProgressRegistration(2);
    }
  }

  void _onFinishRegistration() async {
    final userInformation = _userInformationController.getUserInformation();
    final addressInformation = _addresFieldsController.getAddressInformation();

    await _controller.handleRegistrationNewUser(
      userInformation: userInformation,
      addressInformation: addressInformation,
    );

    _controller.onChangeProgressRegistration(3);
  }

  void _animateToPage(int index) async {
    _pageController.animateToPage(
      index,
      curve: Curves.easeIn,
      duration: Durations.transition,
    );
  }

  void _onCloseRegistrationScreen(
    RegsitrationSection section,
  ) async {
    switch (section) {
      case RegsitrationSection.enterRegistrationData:
        Modular.to.pop();
        break;
      case RegsitrationSection.enterMainAddressInformation:
        _animateToPage(0);
        break;
      case RegsitrationSection.finishRegistration:
        _animateToPage(1);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: StreamBuilder<RegistrationState>(
        stream: _controller.registrationStateStream,
        builder: (context, snapshot) {
          final states = snapshot.data;

          return Visibility(
            child: _backButton(),
            visible: states is! RegistrationSuccessState,
          );
        },
      ),
    );
  }

  Widget _backButton() {
    return StreamBuilder<int>(
      stream: _controller.progressRegistrationStream,
      builder: (context, snapshot) {
        final currentPage = snapshot.data ?? 0;

        final typeIndex = currentPage == 3 ? 2 : currentPage;
        return BackButton(
          color: AppColors.black,
          onPressed: () => _onCloseRegistrationScreen(
            RegsitrationSection.values[typeIndex],
          ),
        );
      },
    );
  }

  Widget _header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _headerTitle(),
        const VerticalSpacing(40),
        _steps(),
        const VerticalSpacing(40),
      ],
    );
  }

  Widget _headerTitle() {
    return const AutoSizeText(
      Strings.resgitrationHeaderTitle,
      minFontSize: 34,
      style: TextStyles.resgitrationHeaderTitle,
    );
  }

  Widget _steps() {
    return StreamBuilder<int>(
      stream: _controller.progressRegistrationStream,
      builder: (context, snapshot) {
        final progress = snapshot.data ?? 0;
        return SizedBox(
          child: Progress(progress: progress),
          width: Dimens.registrationMaxWithProgress,
        );
      },
    );
  }

  Widget _body() {
    return Padding(
      padding: Paddings.bodyHorizontal,
      child: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          onPageChanged: _controller.onChangeProgressRegistration,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            UserFormFields(
              headerWidget: _header(),
              controller: _userInformationController,
              onSubmitted: _onSubmittedUserFormFields,
            ),
            AddressFormFields(
              headerWidget: _header(),
              onValidateFields: _validatesFields,
              controller: _addresFieldsController,
              onSubmitted: _onSubmittedAddressFormFields,
            ),
            TermOfUse(
              headerWidget: _header(),
              controller: _termOfUseController,
              onFinishRegistration: _onFinishRegistration,
              registrationStateStream: _controller.registrationStateStream,
            ),
            _registrationResultSucessSection()
          ],
        ),
      ),
    );
  }

  Widget _registrationResultSucessSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _registrationResultSucessIllustration(),
        const VerticalSpacing(64),
        _registrationResultSucessText(),
      ],
    );
  }

  Widget _registrationResultSucessIllustration() {
    return Center(
      child: SvgPicture.asset(
        Svgs.onBoarding1,
      ),
    );
  }

  Widget _registrationResultSucessText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          Strings.registrationCompleted,
          minFontSize: 24,
          textAlign: TextAlign.center,
          style: TextStyles.resgitrationHeaderTitle.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        const VerticalSpacing(16),
        AutoSizeText(
          Strings.registrationCompletedMessage,
          minFontSize: 14,
          textAlign: TextAlign.center,
          style: TextStyles.resgitrationHeaderTitle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
