import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';
import '../../models/models.dart';

import '../../types/types.dart';
import 'states/address_states.dart';
import 'states/country_list_state.dart';

abstract class AddressFormController {
  Stream<AddressStates> get addressStateStream;
  Stream<CountryListState> get countryListStream;
  Stream<AddressFormSection> get addressFormSectionStream;

  void onFormSection(int index);
  void onFieldChanged(AddressFormType formType, String value);

  String? getZipcode();

  Country? getCurrentCountrySelected();
  void upateCurrentCountrySelected(Country? country);

  AddressInformation getAddressInformation();
  Future<void> updateAddressFormFieldWithZipcode(String zipcode);

  Future<void> init();
  void dispose();
}

class AddressFormControllerImpl implements AddressFormController {
  final LoadCountrysUsecase loadCountrysUsecase;

  AddressFormControllerImpl({
    required this.loadCountrysUsecase,
  });

  Country? _currentCountrySelected;
  final _addressInformation = AddressInformation();

  final _formSectionSubject = BehaviorSubject<AddressFormSection>.seeded(
    AddressFormSection.firstSection,
  );

  final _countryListSubject = BehaviorSubject<CountryListState>.seeded(
    const CountryListLoadingState(),
  );

  final _addressInformationSubject = BehaviorSubject<AddressStates>.seeded(
    const AddressLoadingState(),
  );

  @override
  Stream<AddressFormSection> get addressFormSectionStream =>
      _formSectionSubject.stream.distinct();

  @override
  Stream<CountryListState> get countryListStream =>
      _countryListSubject.stream.distinct();

  @override
  Stream<AddressStates> get addressStateStream =>
      _addressInformationSubject.stream.distinct();

  @override
  Future<void> init() async {
    await loadCountryList();
    startListener();
  }

  void startListener() {
    _countryListSubject.listen((states) {
      if (states is CountryListSuccessState) {
        final countries = states.listOfCountry;
        _currentCountrySelected = countries.fromBrazilianCountry;
        _addressInformation.country = _currentCountrySelected?.name ?? '';
      }
    });
  }

  @override
  void onFormSection(int index) {
    if (!_formSectionSubject.isClosed) {
      _formSectionSubject.add(AddressFormSection.values[index]);
    }
  }

  @override
  void onFieldChanged(AddressFormType formType, String value) {
    switch (formType) {
      case AddressFormType.country:
        _addressInformation.country = value;
        break;
      case AddressFormType.zipcode:
        _addressInformation.zipcode = _setZipcode(value);
        break;
      case AddressFormType.street:
        _addressInformation.street = value;
        break;
      case AddressFormType.number:
        _addressInformation.houseNumber = value;
        break;
      case AddressFormType.city:
        _addressInformation.city = value;
        break;
      case AddressFormType.district:
        _addressInformation.district = value;
        break;
      case AddressFormType.complement:
        _addressInformation.complement = value;
        break;
      case AddressFormType.state:
        _addressInformation.state = value;
        break;
    }
  }

  String _setZipcode(String? value) {
    if (value != null && value.length <= 9) {
      return value;
    }

    return _addressInformation.zipcode ?? '';
  }

  void onChangeCountryListState(CountryListState newState) {
    if (!_countryListSubject.isClosed) {
      _countryListSubject.add(newState);
    }
  }

  Future<void> loadCountryList() async {
    onChangeCountryListState(const CountryListLoadingState());

    try {
      final listOfCountry = await loadCountrysUsecase();

      onChangeCountryListState(CountryListSuccessState(
        listOfCountry: listOfCountry..sortByCountryName,
      ));
    } on ApiClientError catch (e) {
      onChangeCountryListState(CountryListErrorState(
        message: e.message,
      ));
    }
  }

  void onChangeAddressState(AddressStates newState) {
    if (!_addressInformationSubject.isClosed) {
      _addressInformationSubject.add(newState);
    }
  }

  void updateFormFields(GeneralAddressInformation information) {
    _addressInformation.city = information.city;
    _addressInformation.state = information.state;
    _addressInformation.street = information.street;
    _addressInformation.district = information.district;
  }

  @override
  Future<void> updateAddressFormFieldWithZipcode(String zipcode) async {
    onChangeAddressState(const AddressLoadingState());

    try {
      final information = await loadCountrysUsecase.getAddressInformation(
        zipcode: zipcode,
      );

      onChangeAddressState(AddressSuccessState(
        information: information,
      ));
      updateFormFields(information);
    } on ApiClientError catch (e) {
      onChangeAddressState(AddressErrorState(
        message: e.message,
      ));
    }
  }

  @override
  String? getZipcode() {
    return _addressInformation.zipcode;
  }

  @override
  Country? getCurrentCountrySelected() {
    return _currentCountrySelected;
  }

  @override
  void upateCurrentCountrySelected(Country? country) {
    _currentCountrySelected = country;
    _addressInformation.country = country?.name ?? '';
  }

  @override
  AddressInformation getAddressInformation() {
    return _addressInformation.cleanMaskValues();
  }

  @override
  void dispose() {
    _formSectionSubject.close();
    _countryListSubject.close();
    _addressInformationSubject.close();
  }
}
