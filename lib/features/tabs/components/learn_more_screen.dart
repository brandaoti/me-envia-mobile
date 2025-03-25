import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/core.dart';

class LearnMoreScreen extends StatefulWidget {
  const LearnMoreScreen({Key? key}) : super(key: key);

  @override
  _LearnMoreScreenState createState() => _LearnMoreScreenState();
}

class _LearnMoreScreenState extends State<LearnMoreScreen> {
  final List<CardEditItem> _cardItens = [
    const CardEditItem(
      icon: IconsData.iconEditPersonal,
      title: Strings.whoIsMaria,
    ),
    const CardEditItem(
      icon: IconsData.iconEditEnd,
      title: Strings.shippingCost,
    ),
    const CardEditItem(
      icon: IconsData.iconTaxes,
      title: Strings.serviceTaxes,
    ),
    const CardEditItem(
      icon: IconsData.iconHelp,
      title: Strings.faq,
    ),
    const CardEditItem(
      icon: IconsData.iconTutorial,
      title: Strings.seeTutorialAgain,
    ),
    const CardEditItem(
      icon: IconsData.iconForbiddenBottleSkull,
      title: Strings.forbiddenItensTitle,
    ),
  ];
  void _handleLearnMoreNavigation(int index) {
    final Map<int, String> mapToRoutes = {
      0: RoutesName.whoIsMaria.generalInfLinkNavigate,
      1: RoutesName.ourService.generalInfLinkNavigate,
      2: RoutesName.serviceTaxes.generalInfLinkNavigate,
      3: RoutesName.faq.generalInfLinkNavigate,
      4: RoutesName.tutorial.name,
      5: RoutesName.forbiddenItens.generalInfLinkNavigate
    };
    Modular.to.pushNamed(mapToRoutes[index] ?? RoutesName.whoIsMaria.name);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: _body(),
        ),
      ),
    );
  }

  Widget _item(CardEditItem item, int index) {
    return CardEditComponent(
      editItem: item,
      onTap: () {
        _handleLearnMoreNavigation(index);
      },
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VerticalSpacing(MediaQuery.of(context).size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AutoSizeText(
                Strings.learnMore,
                style: TextStyles.learnMoreTitleStyle,
              ),
              const HorizontalSpacing(9),
              Container(
                  padding: const EdgeInsets.only(top: 7),
                  child: const Icon(
                    Icons.info_rounded,
                    size: 32,
                    color: AppColors.secondary,
                  ))
            ],
          ),
          const VerticalSpacing(30),
          Column(
            children: [
              for (int i = 0; i < _cardItens.length; i++)
                _item(_cardItens[i], i)
            ],
          ),
          const VerticalSpacing(40),
        ],
      ),
    );
  }
}
