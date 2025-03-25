import 'package:cubos_extensions/cubos_extensions.dart';
import '../../../core/models/models.dart';

class AddressInformation {
  String? city;
  String? street;
  String? state;
  String? houseNumber;
  String? country;
  String? zipcode;
  String? district;
  String? complement;

  AddressInformation({
    this.city,
    this.street,
    this.houseNumber,
    this.state,
    this.country,
    this.zipcode,
    this.district,
    this.complement,
  });

  AddressInformation copyWith({
    String? city,
    String? street,
    String? houseNumber,
    String? state,
    String? country,
    String? zipcode,
    String? district,
    String? complement,
  }) {
    return AddressInformation(
      city: city ?? this.city,
      state: state ?? this.state,
      street: street ?? this.street,
      country: country ?? this.country,
      zipcode: zipcode ?? this.zipcode,
      district: district ?? this.district,
      complement: complement ?? this.complement,
      houseNumber: houseNumber ?? this.houseNumber,
    );
  }

  AddressInformation cleanMaskValues() {
    return AddressInformation(
      city: city,
      state: state,
      street: street,
      country: country,
      district: district,
      complement: complement,
      houseNumber: houseNumber,
      zipcode: zipcode?.cleanCep ?? '',
    );
  }

  bool get notContaisInformation {
    return (city ?? '').isEmpty &&
        (state ?? '').isEmpty &&
        (street ?? '').isEmpty &&
        (houseNumber ?? '').isEmpty &&
        (country ?? '').isEmpty &&
        (district ?? '').isEmpty &&
        (complement ?? '').isEmpty &&
        (zipcode ?? '').isEmpty;
  }

  Address toAddress() {
    return Address(
      city: city ?? '',
      state: state ?? '',
      street: street ?? '',
      country: country ?? '',
      district: district ?? '',
      complement: complement ?? '',
      houseNumber: houseNumber ?? '',
      zipcode: zipcode?.cleanCep ?? '',
    );
  }

  UpdateAddress toApi() {
    return UpdateAddress(
      city: city,
      street: street,
      state: state,
      country: country,
      district: district,
      complement: complement,
      houseNumber: houseNumber,
      zipcode: zipcode?.cleanCep ?? '',
    );
  }

  @override
  String toString() {
    return 'AddressInformation(city: $city, state: $state, street: $street, houseNumber: $houseNumber, country: $country, zipcode: $zipcode, district: $district, complement: $complement)';
  }
}
