import 'dart:convert';

import 'package:http/http.dart' as http;

import '../client/client.dart';
import '../models/models.dart';

import 'network_connection.dart';

abstract class LocationService {
  Future<CountryList> getCountrysList();
  Future<GeneralAddressInformation> getGeneralAddressInformation({
    required String zipcode,
  });
}

class LocationServiceImpl extends RepositoryErrorHandling
    implements LocationService {
  final ApiClient apiClient;
  final String viaCepApiBaseUrl;

  const LocationServiceImpl({
    required this.apiClient,
    required this.viaCepApiBaseUrl,
    required NetworkConnectionService networkConnectionService,
  }) : super(networkConnectionService: networkConnectionService);

  @override
  Future<CountryList> getCountrysList() async {
    super.checkConnectivity();

    final response = await apiClient.instance.get(
      '/paises?orderBy=name',
    );

    if (response.statusCode != 200) {
      throw Failure(message: 'Erro com serviço externo');
    }

    final listOfCountry = response.data as List;
    return listOfCountry.map((json) => Country.fromJson(json)).toList();
  }

  @override
  Future<GeneralAddressInformation> getGeneralAddressInformation({
    required String zipcode,
  }) async {
    super.checkConnectivity();

    final response = await http.get(Uri.parse(
      '$viaCepApiBaseUrl/$zipcode/json/',
    ));

    if (response.statusCode != 200) {
      throw Failure(message: 'Erro com serviço externo');
    }

    final json = jsonDecode(response.body);
    return GeneralAddressInformation.fromMap(json);
  }
}
