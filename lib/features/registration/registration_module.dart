import 'package:flutter_modular/flutter_modular.dart';

import 'registration_controller.dart';
import '../../core/types/types.dart';
import 'components/components.dart';
import 'registration_screen.dart';

class RegistrationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<UserFormFieldsController>(
      (i) => UserFormFieldsControllerImpl(),
    ),
    Bind.factory<TermOfUseController>(
      (i) => TermOfUseControllerImpl(
        service: i(),
      ),
    ),
    Bind.factory<RegistrationController>(
      (i) => RegistrationControllerImpl(
        authRepository: i(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RoutesName.initial.name,
        child: (_, args) => const RegistrationScreen(),
      ),
    ];
  }
}
