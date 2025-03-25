import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ReceivedBoxCard extends StatefulWidget {
  final bool isSelected;
  final Box cardInfo;
  final OrderStatus orderStatus;
  final VoidCallback? onPressed;

  const ReceivedBoxCard({
    Key? key,
    this.onPressed,
    required this.cardInfo,
    this.isSelected = false,
    this.orderStatus = OrderStatus.viewing,
  }) : super(key: key);

  @override
  _ReceivedBoxCardState createState() => _ReceivedBoxCardState();
}

class _ReceivedBoxCardState extends State<ReceivedBoxCard>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _iconTurns;
  late final AnimationController _controller;
  bool _isExpanded = false;

  void _onExpansionChanged() {
    _isExpanded = !_isExpanded;
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Durations.transition, vsync: this);

    _iconTurns = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.5).chain(
        CurveTween(curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      focusColor: AppColors.transparent,
      hoverColor: AppColors.transparent,
      child: Container(
        child: _body(),
        width: double.infinity,
        alignment: Alignment.center,
        padding: Paddings.expansiontion,
        height: _isExpanded ? 260 : 102,
        decoration: Decorations.cardOrderItem(widget.isSelected),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _header(),
        _expandedProfileImage(),
        const Spacer(),
      ],
    );
  }

  Widget _expandedProfileImage() {
    const double radius = 20;

    return Visibility(
      visible: _isExpanded,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: AnimatedContainer(
          width: double.infinity,
          height: _isExpanded ? 120 : 0,
          duration: Durations.transition,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: ImageCachedLoading(
            radius: radius,
            fit: BoxFit.cover,
            imageUrl: widget.cardInfo.media,
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _profile(),
        const HorizontalSpacing(24),
        _headerText(),
        const Spacer(),
        _expandedIcon()
      ],
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        AutoSizeText(
          widget.cardInfo.description,
          style: TextStyles.orderBoxProduct,
        ),
        const VerticalSpacing(8),
        Visibility(
          child: _headerSubtitle(),
          visible: widget.orderStatus == OrderStatus.viewing,
        )
      ],
    );
  }

  Widget _headerSubtitle() {
    return Row(
      children: const [
        Icon(
          Icons.attach_file,
          size: 14,
          color: AppColors.black,
        ),
        HorizontalSpacing(8),
        AutoSizeText(
          Strings.onePhotoAttached,
          style: TextStyles.orderHeaderPhotoAttached,
        ),
      ],
    );
  }

  Widget _expandedIcon() {
    return IconButton(
      icon: RotationTransition(
        turns: _iconTurns,
        child: const Icon(Icons.arrow_drop_down),
      ),
      onPressed: () => setState(_onExpansionChanged),
    );
  }

  Widget _profile() {
    const Color color = AppColors.cardOrderDisable;

    return Container(
      width: Dimens.orderCardProfileSize,
      height: Dimens.orderCardProfileSize,
      child: _profileItem(color, widget.isSelected),
      decoration: const BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _profileItem(Color color, bool isSelected) {
    switch (widget.orderStatus) {
      case OrderStatus.viewing:
        return CircleAvatar(
          backgroundColor: color,
          maxRadius: Dimens.orderCardProfileSize,
          minRadius: Dimens.orderCardProfileSize,
          backgroundImage: widget.cardInfo.imageIsEmpty
              ? null
              : NetworkImage(widget.cardInfo.media!),
        );
      case OrderStatus.selecting:
        final itemColorMapping = {
          'icon': {
            false: AppColors.grey400,
            true: AppColors.alertGreenColor,
          },
          'background': {
            false: color,
            true: AppColors.alertGreenColorLight,
          }
        };

        return CircleAvatar(
          maxRadius: Dimens.orderCardProfileSize,
          minRadius: Dimens.orderCardProfileSize,
          child: Icon(
            Icons.check_rounded,
            size: 32,
            color: itemColorMapping['icon']![isSelected],
          ),
          backgroundColor: itemColorMapping['background']![isSelected],
        );
    }
  }
}
