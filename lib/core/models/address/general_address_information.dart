class GeneralAddressInformation {
  final String city;
  final String state;
  final String street;
  final String district;
  final String zipcode;

  const GeneralAddressInformation({
    required this.city,
    required this.state,
    required this.street,
    required this.zipcode,
    required this.district,
  });

  factory GeneralAddressInformation.fromMap(Map json) {
    return GeneralAddressInformation(
      state: json['uf'],
      zipcode: json['cep'],
      city: json['localidade'],
      district: json['bairro'],
      street: json['logradouro'],
    );
  }

  Map toMap() {
    return {
      'uf': state,
      'cep': zipcode,
      'bairro': district,
      'localidade': city,
      'logradouro': street,
    };
  }

  @override
  String toString() {
    return 'GeneralAddressInformation(city: $city, state: $state, street: $street, district: $district, zipcode: $zipcode)';
  }
}
