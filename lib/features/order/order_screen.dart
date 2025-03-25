import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../features.dart';

import 'components/order_header.dart';
import 'screens/send_box.dart';

class OrderScreen extends StatefulWidget {
  final int initialOrderIndex;
  final CardController cardController;
  final OrderController orderController;
  final TabBarController tabBarController;

  const OrderScreen({
    Key? key,
    this.initialOrderIndex = 0,
    required this.cardController,
    required this.orderController,
    required this.tabBarController,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: Dimens.lengthGenerateOrderTabs,
      initialIndex: widget.initialOrderIndex,
    );

    _startListener();
    super.initState();
  }

  void _startListener() {
    widget.orderController.init();
    widget.cardController.clearList();

    widget.tabBarController.currentTabIndex.listen((currentIndex) {
      if (currentIndex != 1) {
        widget.orderController.onChangeOrderStatus(OrderStatus.viewing);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: Dimens.lengthGenerateOrderTabs,
        child: Scaffold(
          body: _body(),
          appBar: _appBar(),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return OrderHeader(
      controller: _tabController,
    );
  }

  Widget _body() {
    return Padding(
      padding: Paddings.bodyHorizontal,
      child: TabBarView(
        controller: _tabController,
        children: [
          ReceivedItem(
            cardController: widget.cardController,
            orderController: widget.orderController,
          ),
          const RequestedBoxes(),
          const PendingPaymentBoxes(),
          const SendBox(),
        ],
      ),
    );
  }
}
