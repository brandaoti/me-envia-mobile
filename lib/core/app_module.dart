import 'package:flutter_modular/flutter_modular.dart';
import 'package:connectivity/connectivity.dart';

import 'services/auth_provider.dart';
import '../features/features.dart';
import 'core.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<PrefsDataSource>(
      (i) => PrefsDataSourceImpl(),
    ),
    Bind.singleton<AuthProvider>(
      (i) => AuthProviderImpl(
        prefs: i<PrefsDataSource>(),
      ),
    ),
    Bind.singleton<ApiClient>(
      (i) => ApiClient(
        baseUrl: EnvironmentConfig().apiBaseUrl,
      ),
    ),
    Bind.singleton<PutFileService>(
      (i) => PutFileServiceImpl(),
    ),
    Bind.singleton<NetworkConnectionService>(
      (i) => NetworkConnection(
        connectionChecker: Connectivity(),
      ),
    ),
    Bind.singleton<AuthRepository>(
      (i) => AuthRepositoryImpl(
        apiClient: i<ApiClient>(),
        networkConnectionService: i<NetworkConnectionService>(),
      ),
    ),
    Bind.singleton<AuthController>(
      (i) => AuthControllerImpl(
        service: i(),
        repository: i(),
        authProvider: i(),
      ),
    ),
    Bind.singleton<GeneralInformationRepository>(
      (i) => GeneralInformationRepositoryImpl(
        apiClient: i<ApiClient>(),
        service: i<PutFileService>(),
        networkConnectionService: i<NetworkConnectionService>(),
      ),
    ),
    Bind.singleton<LocationService>(
      (i) => LocationServiceImpl(
        viaCepApiBaseUrl: EnvironmentConfig().viaCepApiBaseUrl,
        networkConnectionService: i<NetworkConnectionService>(),
        apiClient: ApiClient(baseUrl: EnvironmentConfig().locationBaseUrl),
      ),
    ),
    Bind.singleton<CardController>(
      (i) => CardControllerImpl(),
    ),
    Bind.singleton<LoadCountrysUsecase>(
      (i) => LoadCountrysUsecaseImpl(
        locationService: i(),
      ),
    ),
    Bind.singleton<PushNotificationService>(
      (i) => PushNotificationServiceImpl(
        repository: i(),
      ),
    ),
    Bind.factory<SplashController>(
      (i) => SplashControllerImpl(
        connection: i(),
        authProvider: i(),
      ),
    ),
    Bind.factory<MantrasController>(
      (i) => MantrasControllerImpl(),
    ),
    Bind.factory<NoConnectionController>(
      (i) => NoConnectionControllerImpl(
        splashController: i(),
      ),
    ),
    Bind.factory<TutorialController>(
      (i) => TutorialControllerImpl(
        authProvider: i(),
      ),
    ),
    Bind.factory<OnboardingController>(
      (i) => OnboardingControllerImpl(),
    ),
    Bind.factory<LoginController>(
      (i) => LoginControllerImpl(
        authController: i(),
        authRepository: i(),
      ),
    ),
    Bind.factory<ForgotPasswordController>(
      (i) => ForgotPasswordControllerImpl(
        authRepository: i(),
      ),
    ),
    Bind.factory<AddressFormController>(
      (i) => AddressFormControllerImpl(
        loadCountrysUsecase: i(),
      ),
    ),
    Bind.factory<CardSendBoxController>(
      (i) => CardSendBoxControllerImpl(
        repository: i(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RoutesName.initial.name,
        child: (_, args) => const SplashScreen(),
      ),
      ChildRoute(
        RoutesName.mantras.name,
        child: (_, args) => const MantrasScreen(),
      ),
      ChildRoute(
        RoutesName.noConnection.name,
        child: (_, args) => const NoConnection(),
      ),
      ChildRoute(
        RoutesName.onboarding.name,
        child: (_, args) => const OnboardingScreen(),
      ),
      ChildRoute(
        RoutesName.login.name,
        child: (_, args) => const LoginScreen(),
      ),
      ChildRoute(
        RoutesName.tutorial.name,
        child: (context, args) => TutorialScreen(
          isFirstTimeBoardingTheApp: args.data as bool,
        ),
      ),
      ChildRoute(
        RoutesName.forgotPassword.name,
        child: (_, args) => const ForgotPasswordScreen(),
      ),
      ModuleRoute(
        RoutesName.registration.name,
        module: RegistrationModule(),
      ),
      ModuleRoute(
        RoutesName.tabs.name,
        module: TabModule(),
      ),
      ModuleRoute(
        RoutesName.generalInformation.name,
        module: GeneralInformationModule(),
      ),
      ModuleRoute(
        RoutesName.settings.name,
        module: SettingsModule(),
      ),
      ChildRoute(
        RoutesName.pictures.name,
        child: (_, args) => PicturesScreen(
          pictures: args.data as List<String>,
        ),
      ),
    ];
  }
}
