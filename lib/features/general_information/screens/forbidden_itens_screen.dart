import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/values.dart';
import '../components/card_information.dart';
import '../components/screen_header.dart';

class ForbiddenItensScreen extends StatefulWidget {
  const ForbiddenItensScreen({Key? key}) : super(key: key);

  @override
  _ForbiddenItensScreenState createState() => _ForbiddenItensScreenState();
}

class _ForbiddenItensScreenState extends State<ForbiddenItensScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SreenHeader(
            media: Strings.forbiddenItensBackgroundImage,
          ),
          const VerticalSpacing(32),
          Padding(
            padding: Paddings.bodyHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                const VerticalSpacing(8),
                _subtitle(),
                const VerticalSpacing(24),
                const CardInformation(
                  icon: MdiIcons.bottleTonicSkull,
                  subtitleColor: AppColors.secondary,
                  title: Strings.forbiddenItemCardDrugsTitle,
                  subtitle: Strings.forbiddenItemCardDrugsContent,
                ),
                const VerticalSpacing(24),
                const CardInformation(
                  icon: MdiIcons.knifeMilitary,
                  subtitleColor: AppColors.secondary,
                  title: Strings.forbiddenItemCardWeaponTitle,
                  subtitle: Strings.forbiddenItemCardWeaponContent,
                ),
                const VerticalSpacing(24),
                const CardInformation(
                  icon: MdiIcons.biohazard,
                  subtitleColor: AppColors.secondary,
                  title: Strings.forbiddenItemCardBiohazardTitle,
                  subtitle: Strings.forbiddenItemCardBiohazardContent,
                ),
                const VerticalSpacing(38),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.forbiddenItensTitle,
      style: TextStyles.learnMoreTitleStyle,
    );
  }

  Widget _subtitle() {
    return const AutoSizeText(
      Strings.forbiddenItensSubtitle,
      style: TextStyles.whoIsMariaSubtitle,
    );
  }
}
