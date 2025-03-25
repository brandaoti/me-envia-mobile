import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../values/values.dart';
import '../components.dart';

import 'components/send_box_description.dart';
import 'components/send_box_grid_items.dart';
import 'components/send_box_package_status.dart';
import 'states/load_status_history_state.dart';

class CardSendBox extends StatefulWidget {
  final Package package;

  const CardSendBox({
    Key? key,
    required this.package,
  }) : super(key: key);

  @override
  _CardSendBoxState createState() => _CardSendBoxState();
}

class _CardSendBoxState extends State<CardSendBox>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _iconTurns;
  late final AnimationController _animationController;

  final _controller = Modular.get<CardSendBoxController>();

  @override
  void initState() {
    super.initState();
    _controller.init(widget.package);

    _animationController = AnimationController(
      duration: Durations.transition,
      vsync: this,
    );

    _iconTurns = _animationController.drive(
      Tween<double>(begin: 0.0, end: 0.5).chain(
        CurveTween(curve: Curves.easeIn),
      ),
    );

    _startListerner();
  }

  void _startListerner() {
    _controller.isExpanded.listen((isExpanded) async {
      if (isExpanded) {
        _animationController.forward();
        await _controller.loadStatusHistory();
      } else {
        _animationController.reverse();
      }
    });
  }

  Package get package => widget.package;

  @override
  Widget build(BuildContext context) {
    return _isExpandedState(
      builder: (isExpanded) => Container(
        child: _body(),
        width: double.infinity,
        decoration: Decorations.cardOrderItem(false),
        padding:
            isExpanded ? Paddings.sendBoxExpanded : Paddings.listTilePadding,
      ),
    );
  }

  Widget _isExpandedState({required Widget Function(bool) builder}) {
    return StreamBuilder<bool>(
      stream: _controller.isExpanded,
      builder: (context, snapshot) => builder(snapshot.data ?? false),
    );
  }

  Widget _body() {
    return StreamBuilder<LoadStatusState>(
      stream: _controller.loadStatusState,
      builder: (context, snapshot) {
        final states = snapshot.data;

        return _isExpandedState(
          builder: (isExpanded) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                replacement: _initalState(isExpanded: isExpanded),
                child: _packageStatusHistoryState(isExpanded, states),
                visible: isExpanded && states is LoadStatusSucessState,
              ),
              Visibility(
                visible: isExpanded,
                child: _listOfPackageHistoricAndItens(states),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _initalState({
    required bool isExpanded,
    bool countItemsVisible = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: isExpanded ? 2 : 1,
          child: SendBoxPackageStatus(
            isExpanded: isExpanded,
            updateAt: package.updateAt,
            totalItems: package.totalItems,
            countItemsVisible: countItemsVisible,
            statusState: package.boxIconAndColorStatus,
          ),
        ),
        Expanded(
          flex: 3,
          child: SendBoxDescription(
            trackingCode: '',
            type: package.type,
            steps: package.step,
            packageId: package.id,
            status: package.status,
            isExpanded: isExpanded,
            lastPackageUpdateLocation: package.lastPackageUpdateLocation,
          ),
        ),
        _expansionIcon(),
      ],
    );
  }

  Widget _packageStatusHistoryState(
    bool isExpanded,
    LoadStatusState? states,
  ) {
    if (states is! LoadStatusSucessState) {
      return Container();
    }

    if (states.statusHistory.status.isEmpty) {
      return _initalState(isExpanded: isExpanded, countItemsVisible: false);
    }

    final List<Widget> children = [];
    final PackageStatusHistory statusHistory = states.statusHistory;

    final int historyLenght = statusHistory.status.length;
    for (int index = 0; index < historyLenght; index++) {
      children.add(_statusHistoryItem(
        index: index,
        historyLenght: historyLenght,
        history: statusHistory.status[index],
        trackingCode: states.statusHistory.trackingCode ?? '',
      ));
    }

    return Column(
      children: children,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _statusHistoryItem({
    required int index,
    required int historyLenght,
    required String trackingCode,
    required StatusHistory history,
  }) {
    late final Map<String, dynamic> statusState;

    if (index == 0) {
      statusState = {
        'isSvgIcon': false,
        'icon': Icons.check,
        'color': AppColors.alertGreenColor,
        'background': AppColors.alertGreenColorLight,
      };
    } else if (index == (historyLenght - 1)) {
      statusState = {
        'isSvgIcon': false,
        'icon': Icons.arrow_upward_rounded,
        'color': AppColors.alertGreenColor,
        'background': AppColors.alertGreenColorLight,
      };
    } else {
      statusState = {
        'isSvgIcon': true,
        'icon': Svgs.iconBox,
        'color': AppColors.alertGreenColor,
        'background': AppColors.alertGreenColorLight,
      };
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SendBoxPackageStatus(
                totalItems: '',
                isExpanded: true,
                statusState: statusState,
                countItemsVisible: false,
                updateAt: history.statusDate,
              ),
              Visibility(
                visible: historyLenght > 1 && index != (historyLenght - 1),
                child: ConstrainedBox(
                  child: _historyLine(),
                  constraints: const BoxConstraints(
                    maxWidth: Dimens.cardSendBoxHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: SendBoxDescription(
            maxLines: 2,
            isExpanded: true,
            type: package.type,
            stepsVisible: false,
            steps: package.step,
            packageId: package.id,
            status: history.status,
            titleVisible: index == 0,
            trackingCode: trackingCode,
            lastPackageUpdateLocation: history.statusLocal,
          ),
        ),
        Expanded(
          child: Visibility(
            visible: index == 0,
            child: _expansionIcon(),
          ),
        ),
      ],
    );
  }

  Widget _historyLine() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 2,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.grey300,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _listOfPackageHistoricAndItens(LoadStatusState? states) {
    if (states == null ||
        states is LoadStatusErrorState ||
        states is LoadStatusLoadingState) {
      return _loading();
    }

    final statusHistory = (states as LoadStatusSucessState).statusHistory;

    if (states.statusHistory.status.isEmpty) {
      return Container();
    }

    return SendBoxGridItems(
      items: statusHistory.items,
      onPressed: () => _controller.navigateToPicturesScreen(
        statusHistory.items,
      ),
    );
  }

  Widget _loading() {
    return Container(
      height: 120,
      child: const Loading(),
      width: double.infinity,
      alignment: Alignment.center,
      padding: Paddings.vertical,
    );
  }

  Widget _expansionIcon() {
    return Container(
      height: 24,
      alignment: Alignment.center,
      child: ExpansionIcon(
        iconTurns: _iconTurns,
        padding: Paddings.zero,
        onPressed: _controller.onExpansionChanged,
      ),
    );
  }

  // Widget _leftSide(bool isNoReplaceToNewState) {
  //   return _isExpandedState(
  //     builder: (isExpanded) {
  //       return Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Visibility(
  //             visible: isExpanded,
  //             child: Padding(
  //               child: _createUpdateBoxDate(),
  //               padding: const EdgeInsets.only(right: 4),
  //             ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               _circularStatusAndCountItems(isNoReplaceToNewState),
  //               const VerticalSpacing(8),
  //               Visibility(
  //                 visible: !isExpanded,
  //                 child: _createUpdateBoxDate(),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget _circularStatusAndCountItems(bool isNoReplaceToNewState) {
  //   late final Widget child;
  //   final mappinChildState = package.boxIconAndColorStatus;

  //   if (mappinChildState['isSvgIcon']) {
  //     child = Padding(
  //       padding: Paddings.listTilePadding,
  //       child: SvgPicture.asset(
  //         mappinChildState['icon'],
  //         width: Dimens.sendBoxIconSize,
  //         height: Dimens.sendBoxIconSize,
  //         color: mappinChildState['color'],
  //       ),
  //     );
  //   } else {
  //     child = Icon(
  //       mappinChildState['icon'],
  //       size: Dimens.sendBoxIconSize,
  //       color: mappinChildState['color'],
  //     );
  //   }

  //   return Stack(
  //     clipBehavior: Clip.none,
  //     children: [
  //       Container(
  //         decoration: Decorations.boxCarRequestedBox.copyWith(
  //           color: mappinChildState['background'],
  //         ),
  //         child: child,
  //         width: Dimens.cardSendBoxHeight,
  //         height: Dimens.cardSendBoxHeight,
  //       ),
  //       Positioned(
  //         bottom: 0,
  //         right: -5,
  //         child: Visibility(
  //           child: _countItems(),
  //           visible: isNoReplaceToNewState,
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget _countItems() {
  //   return Container(
  //     width: Dimens.horizontal,
  //     height: Dimens.horizontal,
  //     alignment: Alignment.center,
  //     decoration: Decorations.boxCarRequestedBox.copyWith(
  //       color: AppColors.whiteDefault,
  //     ),
  //     child: AutoSizeText(
  //       package.totalItems,
  //       style: TextStyles.boxCountStyle,
  //     ),
  //   );
  // }

  // Widget _createUpdateBoxDate() {
  //   final DateTime updateAt = package.updateAt;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       AutoSizeText(
  //         updateAt.toMonthAbbreStr,
  //         style: TextStyles.toMonthAbbreStrStyle,
  //       ),
  //       const VerticalSpacing(4),
  //       AutoSizeText(
  //         updateAt.toHourAbbreStr,
  //         style: TextStyles.toHourAbbreStrStyle,
  //       ),
  //     ],
  //   );
  // }

  // Widget _rigthSide(bool isNoReplaceToNewState) {
  //   const double paddingLeft = 3;
  //   final String id = package.id;

  //   return Padding(
  //     padding: Paddings.sendBoxCard,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(left: paddingLeft),
  //           child: _boxTitle(title: Strings.boxWithId(id.substring(0, 4))),
  //         ),
  //         const VerticalSpacing(8),
  //         _lastUpdatedLocation(isNoReplaceToNewState),
  //         const VerticalSpacing(8),
  //         Padding(
  //           child: _packageStatus(isNoReplaceToNewState),
  //           padding: const EdgeInsets.only(left: paddingLeft),
  //         ),
  //         const VerticalSpacing(8),
  //         Padding(
  //           child: _deliverySteps(isNoReplaceToNewState),
  //           padding: const EdgeInsets.only(left: paddingLeft),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _boxTitle({
  //   required String title,
  //   bool isItemLengthText = false,
  // }) {
  //   return AutoSizeText(
  //     title,
  //     maxLines: 1,
  //     minFontSize: 16,
  //     overflow: TextOverflow.ellipsis,
  //     style: TextStyles.boxTitleStyle.copyWith(
  //       color: isItemLengthText ? AppColors.pureblack : null,
  //       fontWeight: isItemLengthText ? FontWeight.w600 : null,
  //     ),
  //   );
  // }

  // Widget _lastUpdatedLocation(bool isReplaceToNewState) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Icon(
  //         Icons.pin_drop,
  //         size: 16,
  //         color: AppColors.secondaryLightText,
  //       ),
  //       const HorizontalSpacing(4),
  //       _lastPackageUpdateLocation(package.lastPackageUpdateLocation ?? ''),
  //     ],
  //   );
  // }

  // Widget _lastPackageUpdateLocation(String location) {
  //   return AutoSizeText(
  //     location,
  //     maxLines: 1,
  //     minFontSize: 12,
  //     overflow: TextOverflow.ellipsis,
  //     style: TextStyles.textLocationStyle,
  //   );
  // }

  // Widget _packageStatus(bool isNoReplaceToNewState) {
  //   return AutoSizeText(
  //     package.status ?? '',
  //     minFontSize: 12,
  //     overflow: TextOverflow.ellipsis,
  //     maxLines: isNoReplaceToNewState ? 1 : 2,
  //     style: TextStyles.textLocationStyle.copyWith(
  //       color: AppColors.secondary,
  //       fontWeight: FontWeight.normal,
  //     ),
  //   );
  // }

  // Widget _deliverySteps(bool isNoReplaceToNewState) {
  //   return Visibility(
  //     visible: isNoReplaceToNewState,
  //     child: DeliverySteps(
  //       width: 120,
  //       height: 20,
  //       type: package.type ?? PackageType.warning,
  //       steps: package.step ?? PackageStep.not_send,
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
