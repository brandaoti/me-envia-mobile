import 'package:flutter_modular/flutter_modular.dart';
import '../../core/types/types.dart';
import 'settings.dart';

class SettingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<SenttingsController>(
      (i) => SenttingsControllerImpl(
        repository: i(),
        authController: i(),
      ),
    ),
    Bind.factory<EditUserProfileController>(
      (i) => EditUserProfileControllerImpl(
        repository: i(),
        authController: i(),
      ),
    ),
    Bind.factory<EditAddressController>(
      (i) => EditAddressControllerImpl(
        repository: i(),
        authController: i(),
        loadCountrysUsecase: i(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RoutesName.initial.name,
        child: (_, args) => const SettingsScreen(),
      ),
      ChildRoute(
        RoutesName.editUserInformation.name,
        child: (_, args) => const EditProfileScreen(),
      ),
      ChildRoute(
        RoutesName.editAddressInformation.name,
        child: (_, args) => const EditAddress(),
      ),
    ];
  }
}
