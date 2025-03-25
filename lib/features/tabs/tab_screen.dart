import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:maria_me_envia/core/core.dart';

import '../features.dart';

class TabScreen extends StatefulWidget {
  final TabScreenParams? params;

  const TabScreen({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _controller = Modular.get<TabBarController>();
  final _cardController = Modular.get<CardController>();
  final _orderController = Modular.get<OrderController>();

  int _defaultInitialOrderIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.params?.initialTabIndex ?? _defaultInitialOrderIndex,
    );

    _startListener();
    super.initState();
  }

  void _startListener() {
    _onChangeCurrentIndex(
      widget.params?.initialTabIndex ?? _defaultInitialOrderIndex,
    );
    _onChangedDefaultInitialOrder(0);
  }

  void _onChangedDefaultInitialOrder(int index) {
    setState(() {
      _defaultInitialOrderIndex = index;
    });
  }

  void _onChangeCurrentIndex(int index) {
    _tabController.animateTo(index);
    _controller.onChangeCurrentIndex(index);
  }

  void _onNaviteToSendPackages() {
    _onChangeCurrentIndex(1);
    _onChangedDefaultInitialOrder(
      _defaultInitialOrderIndex = Dimens.lengthGenerateOrderTabs - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _body()),
            _tabBar(),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(
            onNaviteToSendPackages: _onNaviteToSendPackages,
          ),
          OrderScreen(
            tabBarController: _controller,
            cardController: _cardController,
            orderController: _orderController,
            initialOrderIndex:
                widget.params?.initialOrderIndex ?? _defaultInitialOrderIndex,
          ),
          const LearnMoreScreen(),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return StreamBuilder<int>(
      stream: _controller.currentTabIndex,
      builder: (context, snapshot) => TabBarWidget(
        onCreateNewBox: () {
          final list = _cardController.getCurrentBoxList();
          _orderController.handleCreateBox(list);
        },
        controller: _cardController,
        currentTabIndex: snapshot.data ?? 0,
        onChangeIndex: _onChangeCurrentIndex,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    _orderController.dispose();
    super.dispose();
  }
}
