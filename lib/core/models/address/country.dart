typedef CountryList = List<Country>;

class Country {
  final String name;
  final String region;

  const Country({
    required this.name,
    required this.region,
  });

  factory Country.fromJson(Map json) {
    final regionMapValue = json['sub-regiao']['regiao'];
    return Country(
      name: json['nome'] ?? '',
      region: regionMapValue['nome'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'region': region,
    };
  }

  @override
  String toString() => 'Country(name: $name, region: $region)';
}
