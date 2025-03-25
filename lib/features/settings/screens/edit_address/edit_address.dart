import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

import '../../states/edit_address_state.dart';
import '../../settings.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({Key? key}) : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _pageController = PageController();

  final _countryFormFields = FormFields();
  final _zipcodeFormFields = FormFields.mask(mask: '00000-000');

  final _streetFormFields = FormFields();
  final _numberFormFields = FormFields();
  final _cityFormFields = FormFields();
  final _stateFormFields = FormFields();
  final _districtFormFields = FormFields();
  final _complementFormFields = FormFields();

  final _controller = Modular.get<EditAddressController>();

  @override
  void initState() {
    _controller.init();
    _startListener();
    super.initState();
  }

  void _startListener() {
    _controller.editAddressStateStream.listen((states) {
      if (states is EditAddressSuccessState) {
        _animateToPage(1);
        _navigateToSettnsScreen();
      }
    });

    _controller.addressStateStream.listen(_updateAddressFormField);
  }

  void _navigateToSettnsScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Modular.to.pop();
  }

  void _updateAddressFormField(AddressStates addressStates) {
    if (addressStates is AddressSuccessState) {
      final address = addressStates.information;
      _cityFormFields.controller?.text = address.city;
      _stateFormFields.controller?.text = address.state;
      _streetFormFields.controller?.text = address.street;
      _districtFormFields.controller?.text = address.district;

      _numberFormFields.controller?.text = addressStates.number ?? '';
      _complementFormFields.controller?.text = addressStates.complement ?? '';

      _zipcodeFormFields.controller?.text = address.zipcode;
      _countryFormFields.controller?.text = addressStates.country ?? '';
    }
  }

  void _jumpToSegundSection() {
    _controller.onFormSection(1);
  }

  void _handleEditAddress() {
    _controller.handleEditUserInformation();
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.easeIn,
      duration: Durations.transition,
    );
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

  void _onClosedScreen(AddressFormSection section) {
    switch (section) {
      case AddressFormSection.firstSection:
        Modular.to.pop();
        break;
      case AddressFormSection.segundSection:
        _controller.onFormSection(0);
        break;
    }
  }

  Widget _backButton() {
    return StreamBuilder<AddressFormSection>(
      stream: _controller.addressFormSectionStream,
      initialData: AddressFormSection.firstSection,
      builder: (context, snapshot) => BackButton(
        color: AppColors.secondary,
        onPressed: () => _onClosedScreen(snapshot.data!),
      ),
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.editAdress,
      minFontSize: 34,
      style: TextStyles.resgitrationHeaderTitle,
    );
  }

  Widget _body() {
    return SafeArea(
      child: Center(
        child: Padding(
          child: _addressStatesWiget(),
          padding: Paddings.bodyHorizontal,
        ),
      ),
    );
  }

  Widget _addressStatesWiget() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _content(),
        const EditDone(),
      ],
    );
  }

  Widget _content() {
    return StreamBuilder<AddressFormSection>(
      stream: _controller.addressFormSectionStream,
      builder: (context, snapshot) {
        final formSection = snapshot.data ?? AddressFormSection.firstSection;

        return SingleChildScrollView(
          child: Column(
            children: [
              _title(),
              const VerticalSpacing(64),
              Visibility(
                replacement: _addressOtherFields(),
                child: _addressCountryAndZipCode(),
                visible: formSection == AddressFormSection.firstSection,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _addressCountryAndZipCode() {
    return Column(
      children: [
        _countryFormField(),
        const VerticalSpacing(32),
        _zipCodeFormField(),
        const VerticalSpacing(64),
        _onSubmittedButton(
          onPressed: _jumpToSegundSection,
        ),
        const VerticalSpacing(64),
      ],
    );
  }

  Widget _countryFormField() {
    return StreamBuilder<CountryListState>(
      stream: _controller.countryListStream,
      builder: (context, snapshot) {
        CountryList listfOfCountry = [];
        final countryListState = snapshot.data;

        if (countryListState is CountryListSuccessState) {
          listfOfCountry = countryListState.listOfCountry;
        }

        return DropdownButtonFormField<Country>(
          items: _buildCountryItems(listfOfCountry),
          value: _controller.getCurrentCountrySelected(),
          decoration: InputDecoration(
            labelText: Strings.country,
            border: Decorations.inputBorderForms,
            contentPadding: Paddings.inputContentPadding,
          ),
          isExpanded: true,
          style: TextStyles.inputTextStyle,
          iconDisabledColor: AppColors.black,
          focusNode: _countryFormFields.focus,
          iconEnabledColor: AppColors.secondary,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          onChanged: (country) {
            _controller.onFieldChanged(
              AddressFormType.country,
              country?.name ?? '',
            );
          },
          onSaved: (_) {
            _zipcodeFormFields.focus?.requestFocus();
          },
        );
      },
    );
  }

  List<DropdownMenuItem<Country>> _buildCountryItems(
    CountryList listfOfCountry,
  ) {
    return listfOfCountry.map((it) {
      return DropdownMenuItem<Country>(
        value: it,
        child: AutoSizeText(
          it.name,
          style: TextStyles.labelStyle.copyWith(color: AppColors.black),
        ),
      );
    }).toList();
  }

  Widget _zipCodeFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      keyboardType: TextInputType.number,
      focusNode: _zipcodeFormFields.focus,
      textInputAction: TextInputAction.done,
      controller: _zipcodeFormFields.controller,
      decoration: InputDecoration(
        labelText: Strings.zipcode,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
      ),
      onChanged: (value) {
        _controller.onFieldChanged(AddressFormType.zipcode, value);
      },
      onFieldSubmitted: (_) => _jumpToSegundSection,
    );
  }

  Widget _addressOtherFields() {
    return Column(
      children: [
        _streetFormField(),
        const VerticalSpacing(Dimens.vertical),
        _numberFormField(),
        const VerticalSpacing(Dimens.vertical),
        _stateFormField(),
        const VerticalSpacing(Dimens.vertical),
        _cityFormField(),
        const VerticalSpacing(Dimens.vertical),
        _districtFormField(),
        const VerticalSpacing(Dimens.vertical),
        _complementFormField(),
        const VerticalSpacing(48),
        _onSubmittedButton(
          onPressed: _handleEditAddress,
          text: Strings.finishRegistration,
        ),
        const VerticalSpacing(64),
      ],
    );
  }

  Widget _streetFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      focusNode: _streetFormFields.focus,
      textInputAction: TextInputAction.go,
      controller: _streetFormFields.controller,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: Strings.street,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
      ),
      onChanged: (value) {
        _controller.onFieldChanged(AddressFormType.street, value);
      },
      onFieldSubmitted: (_) {
        _numberFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _numberFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      focusNode: _numberFormFields.focus,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.go,
      controller: _numberFormFields.controller,
      decoration: InputDecoration(
        labelText: Strings.number,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        _controller.onFieldChanged(AddressFormType.number, value);
      },
      onFieldSubmitted: (_) {
        _stateFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _stateFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      focusNode: _stateFormFields.focus,
      textInputAction: TextInputAction.go,
      controller: _stateFormFields.controller,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: Strings.state,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
      ),
      onChanged: (value) {
        _controller.onFieldChanged(AddressFormType.state, value);
      },
      onFieldSubmitted: (_) {
        _cityFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _cityFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      focusNode: _cityFormFields.focus,
      textInputAction: TextInputAction.go,
      controller: _cityFormFields.controller,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: Strings.city,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
      ),
      onChanged: (value) {
        _controller.onFieldChanged(AddressFormType.city, value);
      },
      onFieldSubmitted: (_) {
        _districtFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _districtFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      textInputAction: TextInputAction.go,
      focusNode: _districtFormFields.focus,
      keyboardType: TextInputType.streetAddress,
      controller: _districtFormFields.controller,
      decoration: InputDecoration(
        labelText: Strings.district,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
      ),
      onChanged: (value) {
        _controller.onFieldChanged(AddressFormType.district, value);
      },
      onFieldSubmitted: (_) {
        _complementFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _complementFormField() {
    return StreamBuilder<EditAddressState>(
      stream: _controller.editAddressStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final states = snapshot.data;

        if (states is EditAddressErrorState) {
          errorText = states.message;
        }

        return TextFormField(
          style: TextStyles.inputTextStyle,
          textInputAction: TextInputAction.done,
          focusNode: _complementFormFields.focus,
          keyboardType: TextInputType.streetAddress,
          controller: _complementFormFields.controller,
          decoration: InputDecoration(
            errorText: errorText,
            labelText: Strings.complement,
            border: Decorations.inputBorderForms,
            contentPadding: Paddings.inputContentPadding,
          ),
          onChanged: (value) {
            _controller.onFieldChanged(AddressFormType.complement, value);
          },
        );
      },
    );
  }

  Widget _onSubmittedButton({
    VoidCallback? onPressed,
    String text = Strings.nextProgress,
  }) {
    return StreamBuilder<EditAddressState>(
      stream: _controller.editAddressStateStream,
      builder: (context, snapshot) => DefaultButton(
        title: text,
        isValid: true,
        onPressed: onPressed,
        isLoading: snapshot.data is EditAddressLoadingState,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _countryFormFields.dispose();
    _zipcodeFormFields.dispose();
    _streetFormFields.dispose();
    _numberFormFields.dispose();
    _cityFormFields.dispose();
    _stateFormFields.dispose();
    _districtFormFields.dispose();
    _complementFormFields.dispose();
    super.dispose();
  }
}
