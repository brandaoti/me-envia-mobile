import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

import 'components/components.dart';
import 'home_controller.dart';
import 'states/home_state.dart';

typedef BuilderHomeState = Widget Function(HomeState?);

class HomeScreen extends StatefulWidget {
  final VoidCallback? onNaviteToSendPackages;

  const HomeScreen({
    Key? key,
    required this.onNaviteToSendPackages,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Modular.get<HomeController>();
  final _headerController = Modular.get<HeaderController>();

  @override
  void initState() {
    _controller.init();
    _headerController.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: _body(),
      ),
      floatingActionButton: _enterInContactButton(),
    );
  }

  PreferredSizeWidget _appBar() {
    return HomeHeader(
      userStateStream: _controller.userStateStream,
      navigateToSettingsScreen: _controller.navigateToSettingsScreen,
    );
  }

  Widget _body() {
    return Column(
      children: [
        HeaderComponent(
          controller: _headerController,
        ),
        const VerticalSpacing(24),
        _seeAllBox(),
        const VerticalSpacing(24),
        _listOfOrders(),
      ],
    );
  }

  Widget _homeStatesWidget({required BuilderHomeState builder}) {
    return StreamBuilder<HomeState>(
      stream: _controller.homeStateStream,
      builder: (context, snapshot) => builder(snapshot.data),
    );
  }

  Widget _seeAllBox() {
    return Padding(
      padding: Paddings.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            Strings.headerSeeAllText,
            style: TextStyles.headerMoreTips.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          _homeStatesWidget(
            builder: (homeState) => _seeAllButton(
              visible: homeState is HomeSucessState,
              onPressed: widget.onNaviteToSendPackages,
            ),
          )
        ],
      ),
    );
  }

  Widget _seeAllButton({
    required bool visible,
    required VoidCallback? onPressed,
  }) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        width: 80,
        height: 40,
        child: RoundedButton(
          isValid: true,
          onPressed: onPressed,
          title: Strings.headerSeeAllButtonText,
          textStyle: TextStyles.orderHeaderPhotoAttached.copyWith(
            color: AppColors.primary,
          ),
          padding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }

  Widget _listOfOrders() {
    return _homeStatesWidget(
      builder: (states) {
        if (states is HomeSucessState) {
          return _content(states.packages);
        }

        if (states is HomeLoadingState) {
          return const Loading(useContainerBox: true);
        }

        if (states is HomeEmptyState) {
          return Padding(
            child: _noItemsOutOfStock(),
            padding: const EdgeInsets.only(bottom: 38),
          );
        }

        return Container();
      },
    );
  }

  Widget _content(PackageList packages) {
    return Padding(
      padding: Paddings.horizontal,
      child: Column(
        children: packages.map(_sendBoxItem).toList(),
      ),
    );
  }

  Widget _sendBoxItem(Package package) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: CardSendBox(package: package),
    );
  }

  Widget _noItemsOutOfStock() {
    return NoOrderItemWidget(
      title: Strings.letStart,
      useReviewTutorialButton: true,
      padding: Paddings.bodyHorizontal,
      onPressed: _controller.navigateToStockAddressScreen,
    );
  }

  Widget _enterInContactButton() {
    return FloatingActionButton(
      onPressed: Helper.enterInContactWithMaria,
      backgroundColor: AppColors.whatsAppColor,
      child: Padding(
        padding: Paddings.listTilePadding,
        child: SvgPicture.asset(Svgs.iconWhatsApp),
      ),
    );
  }
}
