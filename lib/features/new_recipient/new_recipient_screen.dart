import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maria_me_envia/core/core.dart';

import '../features.dart';
import 'components/created_new_recipient.dart';
import 'components/modal_create_box_confirmation.dart';

class NewRecipient extends StatefulWidget {
  final ScreenParams params;

  const NewRecipient({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  _NewRecipientState createState() => _NewRecipientState();
}

class _NewRecipientState extends State<NewRecipient> {
  final _formKey = GlobalKey<FormState>();

  final _nameFormFields = FormFields();
  final _cpfFormFields = FormFields.mask(mask: '000.000.000-00');

  final _controller = Modular.get<NewRecipientController>();

  @override
  void initState() {
    _controller.init();
    _startListener();
    super.initState();
  }

  void _startListener() {
    _controller.createBoxStateStream.listen((states) {
      if (states is CreateBoxSucessState) {
        _controller.onChangeSectionState(3);
        _handleCreateBoxSucess();
      }
    });
  }

  void _handleCreateBoxSucess() async {
    await Future.delayed(const Duration(seconds: 1));

    _showModalDropShipping(
      isDropShipping: false,
      onConfirm: (_) => _controller.handleCreateBoxSucess(),
    );
  }

  bool _onValidateFields() => _formKey.currentState?.validate() ?? false;

  void _handleChooseDropShipping(bool isDropShipping) {
    _controller.handleChooseDropShipping(
      cpf: _cpfFormFields.getText ?? '',
      name: _nameFormFields.getText ?? '',
      isDropShipping: isDropShipping,
      boxList: widget.params.boxList,
    );
  }

  void _showModalDropShipping({
    bool isDropShipping = true,
    ValueChanged<bool>? onConfirm,
  }) {
    ModalCreateBoxConfirmation(
      context: context,
      isDropShipping: isDropShipping,
      onConfirm: onConfirm ?? _handleChooseDropShipping,
    ).show();
  }

  void _onSubmitted(AddressFormSection section) {
    switch (section) {
      case AddressFormSection.firstSection:
        _controller.onFormSection(1);
        _controller.onChangeSectionState(1);
        break;
      case AddressFormSection.segundSection:
        _controller.onChangeSectionState(2);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _backButton(),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _backButton() {
    return StreamBuilder<NewRecipientSection>(
      stream: _controller.sectionStream,
      initialData: NewRecipientSection.firstSection,
      builder: (context, snapshot) {
        final section = snapshot.data!;

        return Visibility(
          visible: section.index < 2,
          child: BackButton(
            color: AppColors.secondary,
            onPressed: () => _controller.handleOpressedBAckButton(section),
          ),
        );
      },
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: Paddings.horizontal,
      child: Form(
        key: _formKey,
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return StreamBuilder<NewRecipientSection>(
      stream: _controller.sectionStream,
      initialData: NewRecipientSection.firstSection,
      builder: (context, snapshot) {
        final section = snapshot.data!;

        final isThirdSection = section.index >= 2;

        return Visibility(
          visible: isThirdSection,
          replacement: _addressInformation(),
          child: _sucessCretaedNewRecipientSections(section),
        );
      },
    );
  }

  Widget _addressInformation() {
    return StreamBuilder<AddressFormSection>(
      stream: _controller.addressController.addressFormSectionStream,
      builder: (context, snapshot) {
        final section = snapshot.data ?? AddressFormSection.firstSection;
        return Column(
          children: [
            _title(),
            const VerticalSpacing(68),
            _userNameAndCpf(section),
            AddressFormFields(
              headerWidget: Container(),
              isResetToInicialFlow: false,
              onValidateFields: _onValidateFields,
              onSubmitted: () => _onSubmitted(section),
              controller: _controller.addressController,
            ),
          ],
        );
      },
    );
  }

  Widget _title() {
    return const SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        Strings.newRecipientTitle,
        textAlign: TextAlign.center,
        style: TextStyles.mariaTipsTitle,
      ),
    );
  }

  Widget _userNameAndCpf(AddressFormSection section) {
    return Visibility(
      visible: section == AddressFormSection.firstSection,
      child: Column(
        children: [
          NameInputComponent(
            formFields: _nameFormFields,
            onFieldSubmitted: (_) {
              _cpfFormFields.focus?.requestFocus();
            },
          ),
          CPFInputComponent(
            formFields: _cpfFormFields,
          ),
          const VerticalSpacing(16),
        ],
      ),
    );
  }

  Widget _sucessCretaedNewRecipientSections(NewRecipientSection section) {
    return Visibility(
      child: _createdNewRecipient(),
      replacement: _createdNewBox(),
      visible: section == NewRecipientSection.thirdSection,
    );
  }

  Widget _createdNewRecipient() {
    return StreamBuilder<CreateBoxState>(
      stream: _controller.createBoxStateStream,
      builder: (context, snapshot) {
        return CreatedNewRecipient(
          onConfirm: _showModalDropShipping,
          onEdit: () => _controller.onChangeSectionState(1),
          isLoading: snapshot.data is CreateBoxLoadingState,
          newAddress: _controller.getNewAddress(
            cpf: _cpfFormFields.getText ?? '',
            name: _nameFormFields.getText ?? '',
          ),
        );
      },
    );
  }

  Widget _createdNewBox() {
    return const CardCreateBox();
  }

  @override
  void dispose() {
    _controller.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
