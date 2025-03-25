import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = Modular.get<SenttingsController>();

  void _handleConfirmDeleteAccount() {
    _controller.init();

    DeleteConfirmation(
      context: context,
      message: Strings.deleteAccountConfirmation,
      onConfirm: _controller.handleDeleteAccount,
      statesStream: _controller.deleteAccountStateStream,
    ).show();
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
      leading: _builderState(
        builder: (state) => Visibility(
          visible: state is! DeleteAccountSuccessState,
          child: const BackButton(color: AppColors.black),
        ),
      ),
    );
  }

  Widget _builderState({required BuilderState<DeleteAccountState> builder}) {
    return StreamBuilder<DeleteAccountState>(
      stream: _controller.deleteAccountStateStream,
      builder: (context, snapshot) => builder(snapshot.data),
    );
  }

  Widget _body() {
    return _builderState(
      builder: (state) => Visibility(
        child: _content(),
        replacement: _done(),
        visible: state is! DeleteAccountSuccessState,
      ),
    );
  }

  Widget _content() {
    return Column(
      children: [
        _title(),
        const VerticalSpacing(32.0),
        _generatedCardItems(),
      ],
    );
  }

  Widget _done() {
    return const Padding(
      padding: Paddings.bodyHorizontal,
      child: Done(
        title: Strings.accountDeletedTitle,
        subtitle: Strings.accountDeletedMessage,
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

  Widget _generatedCardItems() {
    return Expanded(
      child: ListView(
        padding: Paddings.bodyHorizontal,
        children: [
          CardEditComponent(
            onTap: () => Modular.to.pushNamed(
              RoutesName.editUserInformation.linkNavigate,
            ),
            editItem: const CardEditItem(
              icon: IconsData.iconEditPersonal,
              title: Strings.cardEditProfileTitle,
            ),
          ),
          CardEditComponent(
            editItem: const CardEditItem(
              icon: IconsData.iconEditEnd,
              title: Strings.cardEditAddressTitle,
            ),
            onTap: () => Modular.to.pushNamed(
              RoutesName.editAddressInformation.linkNavigate,
            ),
          ),
          CardEditComponent(
            editItem: const CardEditItem(
              icon: MdiIcons.delete,
              title: Strings.deleteAccount,
            ),
            onTap: _handleConfirmDeleteAccount,
          ),
          CardEditComponent(
            editItem: const CardEditItem(
              icon: Icons.logout,
              title: Strings.logout,
            ),
            onTap: _controller.handleLogout,
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
