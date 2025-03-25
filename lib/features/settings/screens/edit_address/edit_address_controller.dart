import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';

import '../../../registration/registration.dart';
import '../../states/edit_address_state.dart';

abstract class EditAddressController {
  Stream<AddressStates> get addressStateStream;
  Stream<CountryListState> get countryListStream;
  Stream<EditAddressState> get editAddressStateStream;
  Stream<AddressFormSection> get addressFormSectionStream;

  void onFormSection(int index);
  void onFieldChanged(AddressFormType formType, String value);

  void handleEditUserInformation();
  Country? getCurrentCountrySelected();

  void init();
  void dispose();
}

class EditAddressControllerImpl implements EditAddressController {
  final AuthRepository repository;
  final AuthController authController;
  final LoadCountrysUsecase loadCountrysUsecase;

  EditAddressControllerImpl({
    required this.repository,
    required this.authController,
    required this.loadCountrysUsecase,
  });

  Country? _currentCountrySelected;
  CountryList listOfCountry = [];

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

  final _editAddressSubject = BehaviorSubject<EditAddressState>();

  @override
  Stream<AddressStates> get addressStateStream =>
      _addressInformationSubject.stream.distinct();

  @override
  Stream<CountryListState> get countryListStream =>
      _countryListSubject.stream.distinct();

  @override
  Stream<AddressFormSection> get addressFormSectionStream =>
      _formSectionSubject.stream.distinct();

  @override
  Stream<EditAddressState> get editAddressStateStream =>
      _editAddressSubject.stream.distinct();

  @override
  void init() async {
    await loadCountryList();
    await setupAddress();
  }

  Future<void> setupAddress() async {
    final user = await authController.getUser();
    onChangeAddressState(AddressSuccessState.fromInternal(
      user?.address,
    ));

    _currentCountrySelected = listOfCountry.getCountryByName(
      user?.address.country ?? '',
    );
  }

  @override
  Country? getCurrentCountrySelected() {
    return _currentCountrySelected;
  }

  void onChangeAddressState(AddressStates newState) {
    if (!_addressInformationSubject.isClosed) {
      _addressInformationSubject.add(newState);
    }
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
      listOfCountry = await loadCountrysUsecase();

      onChangeCountryListState(CountryListSuccessState(
        listOfCountry: listOfCountry..sortByCountryName,
      ));
    } on ApiClientError catch (e) {
      onChangeCountryListState(CountryListErrorState(
        message: e.message,
      ));
    }
  }

  void onChangeEditAddresState(EditAddressState newState) {
    if (!_editAddressSubject.isClosed) {
      _editAddressSubject.add(newState);
    }
  }

  @override
  void handleEditUserInformation() async {
    onChangeEditAddresState(const EditAddressLoadingState());

    if (_addressInformation.notContaisInformation) {
      onChangeEditAddresState(const EditAddressErrorState(
        message: Strings.noUserInformationToUptade,
      ));
      return;
    }

    try {
      final addressInfo = _addressInformation.toApi();
      final newAddress = await repository.updateAddress(addressInfo);

      handleSucessUpdate(newAddress);
      onChangeEditAddresState(const EditAddressSuccessState());
    } on ApiClientError catch (e) {
      onChangeEditAddresState(EditAddressErrorState(
        message: e.message,
      ));
    }
  }

  void handleSucessUpdate(Address newAddress) async {
    final currentUser = await authController.getUser();
    if (currentUser != null) {
      await authController.saveUser(currentUser.copyWithByAddress(
        address: newAddress,
      ));
    }
  }

  @override
  void dispose() {
    _editAddressSubject.close();
    _formSectionSubject.close();
    _countryListSubject.close();
    _addressInformationSubject.close();
  }
}
