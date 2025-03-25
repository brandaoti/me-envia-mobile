import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'states/order_list_states.dart';

abstract class OrderController {
  Stream<OrderStatus> get orderStatusStream;
  Stream<OrderListState> get orderStateStream;

  void handleCreateBox(BoxList list);
  void onChangeOrderStatus(OrderStatus orderStatus);

  void navigateToStockAddressScreen();

  void init();
  void dispose();
}

class OrderControllerImpl implements OrderController {
  final GeneralInformationRepository repository;

  OrderControllerImpl({
    required this.repository,
  });

  final _orderStatusSubject = BehaviorSubject<OrderStatus>.seeded(
    OrderStatus.viewing,
  );

  final _orderStateSubject = BehaviorSubject<OrderListState>.seeded(
    const OrderListEmptyState(),
  );

  @override
  Stream<OrderStatus> get orderStatusStream =>
      _orderStatusSubject.stream.distinct();

  @override
  Stream<OrderListState> get orderStateStream =>
      _orderStateSubject.stream.distinct();

  @override
  void init() async {
    await handleLoadingUserItems();
  }

  @override
  void onChangeOrderStatus(OrderStatus orderStatus) {
    if (!_orderStatusSubject.isClosed) {
      _orderStatusSubject.add(orderStatus);
    }
  }

  void onChangeOrderListState(OrderListState newState) {
    if (!_orderStateSubject.isClosed) {
      _orderStateSubject.add(newState);
    }
  }

  Future<void> handleLoadingUserItems() async {
    onChangeOrderListState(const OrderListLoadingState());

    try {
      final result = await repository.getUserItems();

      if (result.isEmpty) {
        onChangeOrderListState(const OrderListEmptyState());
      } else {
        onChangeOrderListState(OrderListSucessState(boxList: result));
      }
    } on ApiClientError catch (e) {
      onChangeOrderListState(OrderListErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void handleCreateBox(BoxList list) {
    Modular.to.pushNamed(
      RoutesName.recipientInformation.linkNavigate,
      arguments: list,
    );
  }

  @override
  void navigateToStockAddressScreen() {
    Modular.to.pushNamed(RoutesName.addressInformation.linkNavigate);
  }

  @override
  void dispose() {
    _orderStatusSubject.close();
    _orderStateSubject.close();
  }
}
