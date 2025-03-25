import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';
import '../../features/features.dart';

abstract class HomeController {
  Stream<UserState> get userStateStream;
  Stream<HomeState> get homeStateStream;

  void navigateToSettingsScreen();
  void navigateToStockAddressScreen();

  void init();
  void dispose();
}

class HomeControllerImpl implements HomeController {
  final AuthController authController;
  final PushNotificationService service;
  final GeneralInformationRepository repository;

  HomeControllerImpl({
    required this.service,
    required this.repository,
    required this.authController,
  });

  final _homeStateStream = BehaviorSubject<HomeState>();

  final _userStateSubject = BehaviorSubject<UserState>();

  @override
  Stream<HomeState> get homeStateStream => _homeStateStream.stream.distinct();

  @override
  Stream<UserState> get userStateStream => _userStateSubject.stream.distinct();

  @override
  void init() async {
    final user = await authController.getUser();
    if (user != null) {
      onChangeUserState(UserSucessState(
        name: user.name,
      ));
    }

    await loadSendPackages();
    await service.updateFcmTokenFromUser();
  }

  void onChangeHomeState(HomeState newState) {
    if (!_homeStateStream.isClosed) {
      _homeStateStream.add(newState);
    }
  }

  void onChangeUserState(UserState newState) {
    if (!_userStateSubject.isClosed) {
      _userStateSubject.add(newState);
    }
  }

  Future<void> loadSendPackages() async {
    onChangeHomeState(const HomeLoadingState());

    try {
      final result = await repository.getPackages(section: PackageSection.sent);
      if (result.isEmpty) {
        onChangeHomeState(const HomeEmptyState());
        return;
      }

      handleHomeStateSucess(result);
    } on ApiClientError catch (e) {
      onChangeHomeState(HomeErrorState(
        message: e.message ?? '',
      ));
    }
  }

  void handleHomeStateSucess(PackageList packages) {
    final packageWithTrackingCode = packages.sendBoxWithTrackingCode;
    if (packageWithTrackingCode.isEmpty) {
      onChangeHomeState(const HomeEmptyState());
      return;
    }

    onChangeHomeState(HomeSucessState(
      packages: packageWithTrackingCode,
    ));
  }

  @override
  void navigateToSettingsScreen() {
    Modular.to.pushNamed(RoutesName.settings.name);
  }

  @override
  void navigateToStockAddressScreen() {
    Modular.to.pushNamed(RoutesName.addressInformation.linkNavigate);
  }

  @override
  void dispose() {
    _homeStateStream.close();
    _userStateSubject.close();
  }
}
