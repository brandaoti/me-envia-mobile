import '../../../core/core.dart';

abstract class OrderListState {}

class OrderListEmptyState implements OrderListState {
  const OrderListEmptyState();
}

class OrderListLoadingState implements OrderListState {
  const OrderListLoadingState();
}

class OrderListSucessState implements OrderListState {
  final BoxList boxList;

  const OrderListSucessState({
    required this.boxList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderListSucessState && other.boxList == boxList;
  }

  @override
  int get hashCode => boxList.hashCode;

  @override
  String toString() => 'OrderListSucessState(boxList: $boxList)';
}

class OrderListErrorState implements OrderListState {
  final String message;

  const OrderListErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderListErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
