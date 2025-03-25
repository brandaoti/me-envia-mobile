class UpdateAddress {
  final String? city;
  final String? street;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? district;
  final String? complement;
  final String? houseNumber;

  const UpdateAddress({
    this.city,
    this.street,
    this.state,
    this.country,
    this.zipcode,
    this.district,
    this.complement,
    this.houseNumber,
  });

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

  Map toApi() {
    Map data = {};

    if (contaisData(city)) {
      data['city'] = city;
    }

    if (contaisData(zipcode)) {
      data['zipcode'] = zipcode;
    }

    if (contaisData(state)) {
      data['state'] = state;
    }

    if (contaisData(street)) {
      data['street'] = street;
    }

    if (contaisData(houseNumber)) {
      data['houseNumber'] = houseNumber;
    }

    if (contaisData(country)) {
      data['country'] = country;
    }

    if (contaisData(district)) {
      data['neighborhood'] = district;
    }

    if (contaisData(complement)) {
      data['additionalAddress'] = complement;
    }

    return data;
  }

  bool contaisData(String? value) {
    return value != null && value.isNotEmpty;
  }

  @override
  String toString() {
    return 'UpdateAddress(city: $city, state: $state, street: $street, houseNumber: $houseNumber, country: $country, zipcode: $zipcode, district: $district, complement: $complement)';
  }
}
