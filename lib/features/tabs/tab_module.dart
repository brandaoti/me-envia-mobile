import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core.dart';
import '../features.dart';

class TabModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<TabBarController>(
      (i) => TabBarControllerImpl(),
    ),
    Bind.factory<OrderController>(
      (i) => OrderControllerImpl(
        repository: i<GeneralInformationRepository>(),
      ),
    ),
    Bind.factory<RequestedBoxController>(
      (i) => RequestedBoxImpl(
        repository: i(),
      ),
    ),
    Bind.factory<HeaderController>(
      (i) => HeaderControllerImpl(
        repository: i(),
      ),
    ),
    Bind.factory<HomeController>(
      (i) => HomeControllerImpl(
        service: i(),
        repository: i(),
        authController: i(),
      ),
    ),
    Bind.factory<MariaTipsController>(
      (i) => MariaTipsControllerImpl(
        repository: i(),
        authProvider: i(),
      ),
    ),
    Bind.factory<CustomsDeclarationController>(
      (i) => CustomsDeclarationControllerImpl(
        repository: i(),
        cardController: i(),
      ),
    ),
    Bind.factory<RecipientInformationController>(
      (i) => RecipientInformationControllerImpl(
        authController: i(),
      ),
    ),
    Bind.factory<NewRecipientController>(
      (i) => NewRecipientControllerImpl(
        repository: i(),
        cardController: i(),
        addressController: i(),
      ),
    ),
    Bind.factory<CheckoutPaymentController>(
      (i) => CheckoutPaymentControllerImpl(
        service: i(),
        repository: i(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RoutesName.tabs.name,
        child: (context, args) => TabScreen(
          params: args.data as TabScreenParams,
        ),
      ),
      ChildRoute(
        RoutesName.addressInformation.name,
        child: (context, args) => const StockAddressWidget(),
      ),
      ChildRoute(
        RoutesName.mariaTips.name,
        child: (_, args) => const MariaTipsScreen(),
      ),
      ChildRoute(
        RoutesName.mariaTipsDetailScreen.name,
        child: (_, args) => MariaTipsDetaisScreen(mariaTips: args.data),
      ),
      ChildRoute(
        RoutesName.customsDeclaration.name,
        child: (_, args) => CustomsDeclarationScreen(
          params: args.data as ScreenParams,
        ),
      ),
      ChildRoute(
        RoutesName.recipientInformation.name,
        child: (_, args) => RecipientInformation(
          boxList: args.data as BoxList,
        ),
      ),
      ChildRoute(
        RoutesName.newRecipient.name,
        child: (_, args) => NewRecipient(
          params: args.data as ScreenParams,
        ),
      ),
      ChildRoute(
        RoutesName.checkoutPayment.name,
        child: (_, args) => CheckoutPaymentScreen(
          package: args.data as Package,
        ),
      ),
    ];
  }
}
