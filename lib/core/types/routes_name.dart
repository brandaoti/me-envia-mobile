import 'package:flutter_modular/flutter_modular.dart';

enum RoutesName {
  initial,
  noConnection,
  mantras,
  login,
  home,
  onboarding,
  forgotPassword,
  settings,
  editUserInformation,
  editAddressInformation,
  tabs,
  generalInformation,
  registration,
  tutorial,
  tutorialSteps,
  whoIsMaria,
  faq,
  ourService,
  forbiddenItens,
  serviceTaxes,
  addressInformation,
  mariaTips,
  mariaTipsDetailScreen,
  order,
  customsDeclaration,
  recipientInformation,
  newRecipient,
  checkoutPayment,
  pictures,
}

const Map<RoutesName, String> _mapToRouters = {
  RoutesName.initial: '/',
  RoutesName.mantras: '/mantras',
  RoutesName.tabs: '/tabs',
  RoutesName.home: '/home',
  RoutesName.login: '/login',
  RoutesName.onboarding: '/onboarding',
  RoutesName.settings: '/settings',
  RoutesName.forgotPassword: '/forgot_password',
  RoutesName.editUserInformation: '/edit_user_information',
  RoutesName.editAddressInformation: '/edit_address_information',
  RoutesName.addressInformation: '/address_information',
  RoutesName.generalInformation: '/general_information',
  RoutesName.registration: '/registration',
  RoutesName.tutorial: '/tutorial',
  RoutesName.tutorialSteps: '/tutorial_steps',
  RoutesName.whoIsMaria: '/who_is_maria',
  RoutesName.faq: '/faq',
  RoutesName.ourService: '/our_service',
  RoutesName.forbiddenItens: '/forbidden_itens',
  RoutesName.serviceTaxes: '/service_taxes',
  RoutesName.noConnection: '/no_connection',
  RoutesName.mariaTips: '/maria_tips',
  RoutesName.mariaTipsDetailScreen: '/maria_tips_details_screen',
  RoutesName.order: '/order',
  RoutesName.customsDeclaration: '/customs_declaration',
  RoutesName.recipientInformation: '/recipient_information',
  RoutesName.newRecipient: '/new_recipient',
  RoutesName.checkoutPayment: '/checkout_payment',
  RoutesName.pictures: '/pictures',
};

extension RoutesNameExtension on RoutesName {
  String get name {
    return _mapToRouters[this] ?? '/';
  }

  String get generalInfLinkNavigate {
    final moduleName = RoutesName.generalInformation.name;
    final navigateTo = _mapToRouters[this] ?? '/';

    return '$moduleName$navigateTo';
  }

  String get linkNavigate {
    final router = _mapToRouters[this];
    final module = Modular.to.modulePath;

    return '$module$router';
  }
}

extension FromRoutesNameExtension on String {
  RoutesName get fromRouter {
    return _mapToRouters.keys.firstWhere((it) => this == it.name);
  }
}
