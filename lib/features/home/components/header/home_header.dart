import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/values.dart';
import '../../home.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final Stream<UserState> userStateStream;
  final VoidCallback? navigateToSettingsScreen;

  const HomeHeader({
    Key? key,
    required this.userStateStream,
    this.navigateToSettingsScreen,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _userNameState(),
          ),
          const HorizontalSpacing(16),
          _actionButton(),
        ],
      ),
    );
  }

  Widget _userNameState() {
    return StreamBuilder<UserState>(
      stream: userStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is UserSucessState) {
          return AutoSizeText(
            Strings.homeHeaderUserName(states.getAbbreviationName),
            maxLines: 1,
            minFontSize: 18,
            style: TextStyles.headerMoreTips.copyWith(
              fontWeight: FontWeight.w600,
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _actionButton() {
    return InkWell(
      onTap: navigateToSettingsScreen,
      highlightColor: AppColors.transparent,
      child: const Icon(
        Icons.settings,
        color: AppColors.black,
      ),
    );
  }
}
