import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

import '../../../core/core.dart';

abstract class GeneralInformationRepository {
  Future<MariaInformation> getMariaInformation({
    MariaInformationParams params = MariaInformationParams.whoIsMaria,
  });

  Future<List<Faq>> getAllFaq();

  Future<BoxList> getUserItems();
  Future<MariaTipsList> getMariaTips();

  Future<PackageList> getPackages({
    PackageSection section = PackageSection.created,
  });

  Future<Package> getPackageById({
    required String packageId,
  });

  Future<PackageStatusHistory> getPackageHistory({
    required String packageId,
  });

  Future createPackages({
    required NewPackage newPackage,
  });

  Future<Quotation> getQuotation();

  Future<void> uploadProofOfPayment({
    required String packageId,
    required PutFile putFile,
  });
}

class GeneralInformationRepositoryImpl extends RepositoryErrorHandling
    implements GeneralInformationRepository {
  final ApiClient apiClient;
  final PutFileService service;

  const GeneralInformationRepositoryImpl({
    required this.apiClient,
    required this.service,
    required NetworkConnectionService networkConnectionService,
  }) : super(networkConnectionService: networkConnectionService);

  @override
  Future<BoxList> getUserItems() async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.get('/users/items/');
      final data = (response.data['items']) as List;
      return data.map((json) => Box.fromJson(json)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getUserItems');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<MariaTipsList> getMariaTips() async {
    try {
      await super.checkConnectivity();
      final response = await apiClient.instance.get('/users/hints');
      final tipList = (response.data['allHints']) as List;

      return tipList.map((json) => MariaTips.fromJson(json)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getMariaTips');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<PackageList> getPackages({
    PackageSection section = PackageSection.created,
  }) async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.get(
        '/packages${section.fromApi}',
      );

      final result = (response.data as List);
      return result.map((json) => Package.fromJson(json)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getPackages');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future createPackages({
    required NewPackage newPackage,
  }) async {
    try {
      await super.checkConnectivity();

      await apiClient.instance.post('/packages', data: newPackage.toApi());
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'createPackages');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<Quotation> getQuotation() async {
    try {
      final response = await apiClient.instance.get('/quotation');
      return Quotation.fromJson(response.data['getDollarRate']);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error);
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<void> uploadProofOfPayment({
    required String packageId,
    required PutFile putFile,
  }) async {
    try {
      await super.checkConnectivity();

      final multipartFile = await _getMultipartFile(putFile);

      await apiClient.instance.put(
        '/user/packages/$packageId',
        data: FormData.fromMap({'paymentVoucher': multipartFile}),
      );
    } on DioError catch (error) {
      print(error.toString());
      print(error.message);
      throw super.mappingDioErrors(error, 'getUserItems');
    } catch (error) {
      print(error.toString());
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  Future<MultipartFile> _getMultipartFile(PutFile putFile) async {
    final compressdFile = await service.compressFile(putFile);
    final file = compressdFile ?? putFile.file!;

    final multipartFile = MultipartFile.fromBytes(
      file.readAsBytesSync(),
      filename: putFile.randomFilename,
      contentType: MediaType.parse(putFile.mediaType),
    );

    return multipartFile;
  }

  @override
  Future<MariaInformation> getMariaInformation({
    MariaInformationParams params = MariaInformationParams.whoIsMaria,
  }) async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.get(
        '/learn-more',
        queryParameters: params.toQueryParams,
      );

      return MariaInformation.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getMariaInformation');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<List<Faq>> getAllFaq() async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.get(
        '/learn-more',
        queryParameters: MariaInformationParams.faq.toQueryParams,
      );

      return (response.data as List).map((it) => Faq.fromJson(it)).toList();
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getMariaInformation');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<Package> getPackageById({
    required String packageId,
  }) async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.get(
        '/packages/$packageId',
      );

      return Package.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getPackages');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }

  @override
  Future<PackageStatusHistory> getPackageHistory({
    required String packageId,
  }) async {
    try {
      await super.checkConnectivity();

      final response = await apiClient.instance.get(
        '/packages/$packageId',
      );

      return PackageStatusHistory.fromJson(response.data);
    } on DioError catch (error) {
      throw super.mappingDioErrors(error, 'getPackages');
    } catch (error) {
      throw Failure(message: Strings.errorUnknownInApi);
    }
  }
}
