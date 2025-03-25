import 'general_address_information.dart';

class Address {
  final String city;
  final String state;
  final String street;
  final String country;
  final String zipcode;
  final String district;
  final String complement;
  final String houseNumber;

  const Address({
    required this.city,
    required this.state,
    required this.street,
    required this.country,
    required this.zipcode,
    required this.district,
    required this.complement,
    required this.houseNumber,
  });

  factory Address.fromJson(Map json) {
    return Address(
      city: json['city'],
      zipcode: json['cep'],
      state: json['state'],
      street: json['street'],
      country: json['country'],
      district: json['neighborhood'],
      houseNumber: json['houseNumber'],
      complement: json['additionalAddress'],
    );
  }

  factory Address.fromGeneralInformation(
    String country,
    String zipcode,
    String number,
    String complement,
    GeneralAddressInformation information,
  ) {
    return Address(
      country: country,
      zipcode: zipcode,
      houseNumber: number,
      city: information.city,
      complement: complement,
      state: information.state,
      street: information.street,
      district: information.district,
    );
  }

  Map toMap() {
    return {
      'city': city,
      'cep': zipcode,
      'state': state,
      'street': street,
      'country': country,
      'neighborhood': district,
      'houseNumber': houseNumber,
      'additionalAddress': complement,
    };
  }

  @override
  String toString() {
    return 'Address(city: $city, state: $state, street: $street, country: $country, zipcode: $zipcode, district: $district, complement: $complement, houseNumber: $houseNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.city == city &&
        other.state == state &&
        other.street == street &&
        other.country == country &&
        other.zipcode == zipcode &&
        other.district == district &&
        other.complement == complement &&
        other.houseNumber == houseNumber;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        state.hashCode ^
        street.hashCode ^
        country.hashCode ^
        zipcode.hashCode ^
        district.hashCode ^
        complement.hashCode ^
        houseNumber.hashCode;
  }
}
