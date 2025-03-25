import 'package:maria_me_envia/core/client/client.dart';

import '../../../core/services/services.dart';
import '../../../core/models/models.dart';

abstract class LoadCountrysUsecase {
  Future<CountryList> call();
  Future<GeneralAddressInformation> getAddressInformation({
    required String zipcode,
  });
}

class LoadCountrysUsecaseImpl implements LoadCountrysUsecase {
  final LocationService locationService;

  const LoadCountrysUsecaseImpl({
    required this.locationService,
  });

  @override
  Future<CountryList> call() async {
    try {
      final listOfCountry = await locationService.getCountrysList();
      return listOfCountry;
    } on ApiClientError catch (_) {
      rethrow;
    } catch (error) {
      throw Failure(message: 'Erro com serviço externo');
    }
  }

  @override
  Future<GeneralAddressInformation> getAddressInformation({
    required String zipcode,
  }) async {
    try {
      final information = await locationService.getGeneralAddressInformation(
        zipcode: zipcode,
      );
      return information;
    } on ApiClientError catch (_) {
      rethrow;
    } catch (error) {
      throw Failure(message: 'Erro com serviço externo');
    }
  }
}
