import '../../../../../core/models/models.dart';

abstract class AddressStates {}

class AddressLoadingState implements AddressStates {
  const AddressLoadingState();
}

class AddressSuccessState implements AddressStates {
  final String? country;
  final String? number;
  final String? complement;
  final GeneralAddressInformation information;

  const AddressSuccessState({
    this.country,
    this.number,
    this.complement,
    required this.information,
  });

  factory AddressSuccessState.fromInternal(Address? address) {
    return AddressSuccessState(
      country: address?.country ?? '',
      number: address?.houseNumber ?? '',
      complement: address?.complement ?? '',
      information: GeneralAddressInformation(
        city: address?.city ?? '',
        state: address?.state ?? '',
        street: address?.street ?? '',
        zipcode: address?.zipcode ?? '',
        district: address?.district ?? '',
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressSuccessState &&
        other.country == country &&
        other.information == information;
  }

  @override
  int get hashCode => country.hashCode ^ information.hashCode;

  @override
  String toString() =>
      'AddressSuccessState(country: $country, information: $information)';
}

class AddressErrorState implements AddressStates {
  final String? message;

  const AddressErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
