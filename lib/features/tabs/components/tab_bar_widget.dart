import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'modal_confirm_order.dart';
import 'tab_bar_item.dart';

typedef HandleChangeIndex = void Function(int);

class TabBarWidget extends StatelessWidget {
  final int currentTabIndex;
  final CardController controller;
  final VoidCallback onCreateNewBox;
  final HandleChangeIndex onChangeIndex;

  const TabBarWidget({
    Key? key,
    required this.controller,
    required this.onChangeIndex,
    required this.onCreateNewBox,
    required this.currentTabIndex,
  }) : super(key: key);

  void _handleChangeIndex(int index) {
    if (index != 1) {
      controller.clearList();
      controller.toggleCreatingBox(false);
    }

    onChangeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: _body(context),
        width: double.infinity,
        decoration: Decorations.tabBarWidget,
        padding: Paddings.bodyHorizontal,
        height: Dimens.tabBarStandardHeight,
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _listOfItems(context),
        _tabBarStep(),
      ],
    );
  }

  Widget _listOfItems(
    BuildContext context,
  ) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabBarItem(
            icon: Svgs.iconHome,
            controller: controller,
            text: Strings.tabBarTexts[0],
            isActive: currentTabIndex == 0,
            onPressed: () => _handleChangeIndex(0),
          ),
          _createBoxTabBarItem(context),
          TabBarItem(
            icon: Svgs.iconInfo,
            controller: controller,
            text: Strings.tabBarTexts[2],
            isActive: currentTabIndex == 2,
            onPressed: () => _handleChangeIndex(2),
          ),
        ],
      ),
    );
  }

  void _handleCreateBox(BuildContext context, bool isSelectedBox) {
    if (!isSelectedBox) {
      _handleChangeIndex(1);
      return;
    }

    controller.showFeedbackMessageToAddItem(false);

    ModalConfirmOrder(
      context: context,
      onConfirm: onCreateNewBox,
      hasItemSelected: controller.hasItemSelected,
      onClosing: () => controller.showFeedbackMessageToAddItem(true),
    ).show();
  }

  Widget _createBoxTabBarItem(BuildContext context) {
    return StreamBuilder<bool>(
      stream: controller.isSelectedBox,
      builder: (context, snapshot) {
        final bool isSelectedBox = snapshot.data ?? false;
        return TabBarItem(
          useAppLogo: true,
          controller: controller,
          text: Strings.tabBarTexts[1],
          isCreatingABox: isSelectedBox,
          isActive: currentTabIndex == 1,
          onPressed: () => _handleCreateBox(context, isSelectedBox),
        );
      },
    );
  }

  Widget _tabBarStep() {
    const Map mappingToAligment = {
      0: Alignment.centerLeft,
      1: Alignment.center,
      2: Alignment.centerRight,
    };

    return AnimatedAlign(
      child: _tabBarStepItem(),
      duration: Durations.transition,
      alignment: mappingToAligment[currentTabIndex],
    );
  }

  Widget _tabBarStepItem() {
    return Container(
      alignment: Alignment.center,
      width: Dimens.tabBarItemsSize,
      child: Container(
        width: 48,
        height: 8,
        decoration: Decorations.tabBarSteps,
      ),
    );
  }
}
