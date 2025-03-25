import '../../../../../core/models/address/country.dart';

abstract class CountryListState {}

class CountryListLoadingState implements CountryListState {
  const CountryListLoadingState();
}

class CountryListSuccessState implements CountryListState {
  final CountryList listOfCountry;

  const CountryListSuccessState({
    required this.listOfCountry,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryListSuccessState &&
        other.listOfCountry == listOfCountry;
  }

  @override
  int get hashCode => listOfCountry.hashCode;

  @override
  String toString() => 'CountryListSuccessState(listOfCountry: $listOfCountry)';
}

class CountryListErrorState implements CountryListState {
  final String? message;

  const CountryListErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryListErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
