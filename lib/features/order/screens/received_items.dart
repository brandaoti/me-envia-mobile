import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../features.dart';

class ReceivedItem extends StatefulWidget {
  final CardController cardController;
  final OrderController orderController;

  const ReceivedItem({
    Key? key,
    required this.cardController,
    required this.orderController,
  }) : super(key: key);

  @override
  _ReceivedItemState createState() => _ReceivedItemState();
}

class _ReceivedItemState extends State<ReceivedItem> {
  void _showModalBoxLimit() {
    BoxModalLimit(
      context: context,
      onClosing: widget.cardController.showFeedbackMessageToListEmpty,
    ).show();
  }

  void _handleChangeSection() {
    widget.cardController.clearList();
    widget.cardController.toggleCreatingBox(true);
    widget.orderController.onChangeOrderStatus(OrderStatus.selecting);
    _showModalBoxLimit();
  }

  void _handleCancelCreateBox() {
    widget.cardController.resetToInitialState();
    widget.orderController.onChangeOrderStatus(OrderStatus.viewing);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderStatus>(
      stream: widget.orderController.orderStatusStream,
      builder: (context, snapshot) {
        final orderState = snapshot.data ?? OrderStatus.selecting;
        final bool isFirstSection = orderState != OrderStatus.selecting;

        return Visibility(
          visible: isFirstSection,
          child: _sectionViewing(),
          replacement: _sectionSelecting(),
        );
      },
    );
  }

  Widget _sectionViewing() {
    return StreamBuilder<OrderListState>(
      stream: widget.orderController.orderStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        return SingleChildScrollView(
          child: Column(
            children: [
              const VerticalSpacing(24),
              _sectionsHeader(
                isCancelButtonVisible: state is OrderListSucessState,
                onPressed: () => Modular.to.pushNamed(
                  RoutesName.addressInformation.linkNavigate,
                ),
              ),
              const VerticalSpacing(16),
              _sectionViewList(state),
              const VerticalSpacing(40),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionViewList(OrderListState? states) {
    if (states is OrderListLoadingState) {
      return const Loading(useContainerBox: true);
    }

    if (states is OrderListErrorState) {
      return const ErrorText(
        height: null,
        message: Strings.noStockItemHome,
      );
    }

    if (states is OrderListEmptyState) {
      return Padding(
        child: _noItemsOutOfStock(),
        padding: const EdgeInsets.only(top: 38),
      );
    }

    if (states is OrderListSucessState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createBoxButton(),
          const VerticalSpacing(24),
          Column(
            children: _generatedOrderCardItems(states.boxList),
          ),
        ],
      );
    }

    return Container();
  }

  Widget _noItemsOutOfStock() {
    return NoOrderItemWidget(
      title: Strings.noStockItems,
      illustration: Svgs.boxGray,
      useReviewTutorialButton: true,
      padding: Paddings.bodyHorizontal,
      illustrationSize: Dimens.imageSize150PX,
      buttonText: Strings.noOrderItemButtonTextStock,
      onPressed: widget.orderController.navigateToStockAddressScreen,
    );
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: OrderCard(
        index: index,
        cardInfo: cardInfo,
        useWrrapperOnPressed: true,
        onImagePressed: () => Modular.to.pushNamed(
          RoutesName.pictures.name,
          arguments: [cardInfo.media],
        ),
      ),
    );
  }

  Widget _sectionsHeader({
    required VoidCallback? onPressed,
    bool isCancelButtonVisible = true,
    String title = Strings.orderScreenTitle,
    String buttonText = Strings.streetInputLabelText,
  }) {
    final style = TextStyles.orderBoxProduct.copyWith(
      height: 1.2,
      fontSize: 24,
    );

    return Row(
      children: [
        SizedBox(
          width: 170,
          child: AutoSizeText(
            title,
            style: style,
          ),
        ),
        const Spacer(),
        Visibility(
          visible: isCancelButtonVisible,
          child: _cancelCreateBoxButton(buttonText, onPressed),
        ),
      ],
    );
  }

  Widget _sectionSelecting() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const VerticalSpacing(24),
          _sectionsHeader(
            onPressed: _handleCancelCreateBox,
            title: Strings.orderScreenSubtitle,
            buttonText: Strings.cancelCreateBoxButtonText,
          ),
          const VerticalSpacing(16),
          CreateOrderBox(
            cardController: widget.cardController,
            orderController: widget.orderController,
          )
        ],
      ),
    );
  }

  Widget _cancelCreateBoxButton(
    String text,
    VoidCallback? onPressed,
  ) {
    return SizedBox(
      width: 85,
      height: 40,
      child: RoundedButton(
        title: text,
        isValid: true,
        onPressed: onPressed,
        padding: const EdgeInsets.all(12),
        textStyle: TextStyles.roundedButton(true).copyWith(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _createBoxButton() {
    return DefaultButton(
      isValid: true,
      title: Strings.createBox,
      onPressed: _handleChangeSection,
    );
  }
}
