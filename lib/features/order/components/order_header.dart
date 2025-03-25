import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class OrderHeader extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;

  const OrderHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Size get preferredSize => Sizes.orderHeaderStandardHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _tabs(),
      color: AppColors.secondary,
      alignment: Alignment.bottomCenter,
      width: Sizes.orderHeaderStandardHeight.width,
      height: Sizes.orderHeaderStandardHeight.height,
    );
  }

  Widget _tabs() {
    return TabBar(
      isScrollable: true,
      controller: controller,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyles.orderHeaderTabBar,
      indicator: Decorations.orderHeaderTabBar,
      tabs: Strings.orderHeaderTabs.map(_tabItem).toList(),
      unselectedLabelColor: AppColors.white.withOpacity(0.8),
      labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    );
  }

  Widget _tabItem(String text) {
    return AutoSizeText(
      text,
      style: TextStyles.orderHeaderTabBar,
    );
  }
}
