import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../registration.dart';

typedef HandleValidatesFields = bool Function();

class AddressFormFields extends StatefulWidget {
  final Widget headerWidget;
  final VoidCallback onSubmitted;
  final bool isResetToInicialFlow;
  final AddressFormController controller;
  final HandleValidatesFields onValidateFields;

  const AddressFormFields({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    required this.headerWidget,
    required this.onValidateFields,
    this.isResetToInicialFlow = true,
  }) : super(key: key);

  @override
  _AddressFormFieldsState createState() => _AddressFormFieldsState();
}

class _AddressFormFieldsState extends State<AddressFormFields> {
  late final FormFields _countryFormFields;
  late final FormFields _zipcodeFormFields;

  late final FormFields _streetFormFields;
  late final FormFields _numberFormFields;
  late final FormFields _cityFormFields;
  late final FormFields _stateFormFields;
  late final FormFields _districtFormFields;
  late final FormFields _complementFormFields;

  @override
  void dispose() {
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

  @override
  void initState() {
    if (widget.isResetToInicialFlow) {
      widget.controller.onFormSection(0);
    }

    _countryFormFields = FormFields();
    _zipcodeFormFields = FormFields.mask(mask: '00000-000');

    _streetFormFields = FormFields();
    _numberFormFields = FormFields();
    _cityFormFields = FormFields();
    _stateFormFields = FormFields();
    _districtFormFields = FormFields();
    _complementFormFields = FormFields();

    _startListener();
    super.initState();
  }

  void _startListener() {
    _zipcodeFormFields.controller?.addListener(() async {
      final String zipcode = _zipcodeFormFields.controller?.text ?? '';
      if (zipcode.length < 9) return;

      await widget.controller.updateAddressFormFieldWithZipcode(zipcode);
    });

    widget.controller.addressStateStream.listen(_updateAddressFormField);
  }

  void _updateAddressFormField(AddressStates addressStates) {
    if (addressStates is AddressSuccessState) {
      final information = addressStates.information;
      _cityFormFields.controller?.text = information.city;
      _stateFormFields.controller?.text = information.state;
      _streetFormFields.controller?.text = information.street;
      _districtFormFields.controller?.text = information.district;

      _numberFormFields.controller?.text = addressStates.number ?? '';
      _complementFormFields.controller?.text = addressStates.complement ?? '';
    }
  }

  void _validateFormFieldsFirstSection() {
    final bool isValid = widget.onValidateFields();

    if (isValid) {
      widget.controller.onFormSection(1);
    }
  }

  void _validateFormFieldsSecondSection() {
    final bool isValid = widget.onValidateFields();

    if (isValid) {
      widget.onSubmitted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.headerWidget,
          _addresBody(),
        ],
      ),
    );
  }

  Widget _addresBody() {
    return StreamBuilder<AddressFormSection>(
      stream: widget.controller.addressFormSectionStream,
      builder: (context, snapshot) {
        final formSection = snapshot.data ?? AddressFormSection.firstSection;

        switch (formSection) {
          case AddressFormSection.firstSection:
            return _addressCountryAndZipCode();
          case AddressFormSection.segundSection:
            return _addressOtherFields();
        }
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
          onPressed: _validateFormFieldsFirstSection,
        ),
        const VerticalSpacing(64),
      ],
    );
  }

  Widget _countryFormField() {
    return StreamBuilder<CountryListState>(
      stream: widget.controller.countryListStream,
      builder: (context, snapshot) {
        CountryList listfOfCountry = [];
        final countryListState = snapshot.data;

        if (countryListState is CountryListSuccessState) {
          listfOfCountry = countryListState.listOfCountry;
        }

        return DropdownButtonFormField<Country>(
          items: _buildCountryItems(listfOfCountry),
          value: widget.controller.getCurrentCountrySelected(),
          decoration: InputDecoration(
            labelText: Strings.country,
            border: Decorations.inputBorderForms,
            contentPadding: Paddings.inputContentPadding,
          ),
          validator: (country) {
            return Validators.required(country?.name ?? '');
          },
          isExpanded: true,
          style: TextStyles.inputTextStyle,
          focusNode: _countryFormFields.focus,
          iconEnabledColor: AppColors.secondary,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          onChanged: (country) {
            widget.controller.onFieldChanged(
              AddressFormType.country,
              country?.name ?? '',
            );
            widget.controller.upateCurrentCountrySelected(country);
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
        child: AutoSizeText(it.name, style: TextStyles.labelStyle),
      );
    }).toList();
  }

  Widget _zipCodeFormField() {
    return TextFormField(
      validator: (value) {
        final currenCountry = widget.controller.getCurrentCountrySelected();
        final isBrazilianCountry = currenCountry?.isBrazilianCountry ?? false;

        return isBrazilianCountry
            ? Validators.cep(value)
            : Validators.required(value);
      },
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
        widget.controller.onFieldChanged(AddressFormType.zipcode, value);
      },
      onFieldSubmitted: (_) => _validateFormFieldsFirstSection(),
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
        const VerticalSpacing(64),
        _onSubmittedButton(
          onPressed: _validateFormFieldsSecondSection,
        ),
        const VerticalSpacing(64),
      ],
    );
  }

  Widget _streetFormField() {
    return TextFormField(
      validator: Validators.required,
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
        widget.controller.onFieldChanged(AddressFormType.street, value);
      },
      onFieldSubmitted: (_) {
        _numberFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _numberFormField() {
    return TextFormField(
      validator: Validators.required,
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
      onChanged: (value) {
        widget.controller.onFieldChanged(AddressFormType.number, value);
      },
      onFieldSubmitted: (_) {
        _stateFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _stateFormField() {
    return TextFormField(
      validator: Validators.required,
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
        widget.controller.onFieldChanged(AddressFormType.state, value);
      },
      onFieldSubmitted: (_) {
        _cityFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _cityFormField() {
    return TextFormField(
      validator: Validators.required,
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
        widget.controller.onFieldChanged(AddressFormType.city, value);
      },
      onFieldSubmitted: (_) {
        _districtFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _districtFormField() {
    return TextFormField(
      validator: Validators.required,
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
        widget.controller.onFieldChanged(AddressFormType.district, value);
      },
      onFieldSubmitted: (_) {
        _complementFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _complementFormField() {
    return TextFormField(
      style: TextStyles.inputTextStyle,
      textInputAction: TextInputAction.done,
      focusNode: _complementFormFields.focus,
      keyboardType: TextInputType.streetAddress,
      controller: _complementFormFields.controller,
      decoration: InputDecoration(
        labelText: Strings.complement,
        border: Decorations.inputBorderForms,
        contentPadding: Paddings.inputContentPadding,
      ),
      onChanged: (value) {
        widget.controller.onFieldChanged(AddressFormType.complement, value);
      },
      onFieldSubmitted: (_) => _validateFormFieldsSecondSection(),
    );
  }

  Widget _onSubmittedButton({
    VoidCallback? onPressed,
  }) {
    return DefaultButton(
      isValid: true,
      onPressed: onPressed,
      title: Strings.nextProgress,
    );
  }
}
