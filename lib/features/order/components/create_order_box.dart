import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../features.dart';

class CreateOrderBox extends StatelessWidget {
  final CardController cardController;
  final OrderController orderController;

  const CreateOrderBox({
    Key? key,
    required this.cardController,
    required this.orderController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderListState>(
      stream: orderController.orderStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;
        BoxList boxList = [];

        if (states is OrderListSucessState) {
          boxList = states.boxList;
        }

        return Column(
          children: [
            const VerticalSpacing(16),
            _header(boxList),
            const VerticalSpacing(20),
            _body(states: states),
          ],
        );
      },
    );
  }

  Widget _header(BoxList boxList) {
    final style = TextStyles.orderBoxProduct.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    return StreamBuilder<BoxList>(
      stream: cardController.cardList,
      builder: (context, snapshot) {
        final cardList = snapshot.data ?? [];

        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 170,
                  child: AutoSizeText(
                    Strings.avaliableItemText,
                    style: style,
                  ),
                ),
                const Spacer(),
                _selectAllBox(
                  style.copyWith(fontSize: 12),
                  cardList: cardList,
                  boxList: boxList,
                ),
              ],
            ),
            const VerticalSpacing(10),
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                Strings.selectedAllItems(cardList.length),
                style: style.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _selectAllBox(
    TextStyle style, {
    required BoxList cardList,
    required BoxList boxList,
  }) {
    final bool isSelectedAll = boxList.length == cardList.length;

    return Row(
      children: [
        AutoSizeText(
          Strings.selectAllItem,
          style: style,
        ),
        const HorizontalSpacing(10),
        CustomRadio(
          isActive: isSelectedAll,
          onChanged: (_) => cardController.addAll(boxList),
        ),
      ],
    );
  }

  Widget _body({
    required OrderListState? states,
  }) {
    if (states is OrderListLoadingState) {
      return const Loading(useContainerBox: true);
    }

    if (states is OrderListErrorState) {
      return ErrorText(
        height: null,
        message: states.message,
      );
    }

    if (states is OrderListEmptyState) {
      return const ErrorText(
        height: null,
      );
    }

    if (states is OrderListSucessState) {
      return Column(
        children: _generatedOrderCardItems(states.boxList),
      );
    }

    return Container();
  }

  List<Widget> _generatedOrderCardItems(BoxList listOfBox) {
    List<Widget> children = [];

    for (int index = 0; index < listOfBox.length; index++) {
      children.add(_orderCardItem(
        index: index + 1,
        cardInfo: listOfBox[index],
      ));
    }

    return children;
  }

  Widget _orderCardItem({
    required int index,
    required Box cardInfo,
  }) {
    return StreamBuilder<BoxList>(
      stream: cardController.cardList,
      builder: (context, snapshot) {
        final cardList = snapshot.data ?? [];

        final isSelected = cardList.any(
          (it) => it.id.compareTo(cardInfo.id) == 0,
        );

        return Padding(
          child: OrderCard(
            index: index,
            cardInfo: cardInfo,
            isSelected: isSelected,
            orderStatus: OrderStatus.selecting,
            onPressed: () => cardController.add(cardInfo),
          ),
          padding: const EdgeInsets.only(bottom: 24.0),
        );
      },
    );
  }
}
