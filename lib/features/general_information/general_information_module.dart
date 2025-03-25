import 'package:flutter_modular/flutter_modular.dart';

import '../../core/types/types.dart';
import 'general_information.dart';

class GeneralInformationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<GeneralInformationController>(
      (i) => GeneralInformationControllerImpl(
        repository: i(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          RoutesName.faq.name,
          child: (_, args) => const FaqScreen(),
        ),
        ChildRoute(
          RoutesName.ourService.name,
          child: (_, args) => const ShippingCostScreen(),
        ),
        ChildRoute(
          RoutesName.whoIsMaria.name,
          child: (_, args) => const WhoIsMariaScreen(),
        ),
        ChildRoute(
          RoutesName.forbiddenItens.name,
          child: (_, args) => const ForbiddenItensScreen(),
        ),
        ChildRoute(
          RoutesName.serviceTaxes.name,
          child: (_, args) => const ServiceTaxesScreen(),
        ),
      ];
}
