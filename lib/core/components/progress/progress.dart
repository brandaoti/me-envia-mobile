import 'package:flutter/material.dart';

import '../../values/values.dart';
import 'dashed_shape.dart';

enum ProgressType {
  initial,
  completed,
  notStarted,
}

class Progress extends StatelessWidget {
  final double height;
  final int progress;
  final double dotteSpacingLine;

  const Progress({
    Key? key,
    this.height = 16,
    this.progress = 0,
    this.dotteSpacingLine = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: _body(),
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _body() {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Center(
          child: _lineDashed(),
        ),
        Center(
          child: _stageOfprogress(),
        ),
      ],
    );
  }

  Widget _stageOfprogress() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _firstDotte(),
        _secondDotte(),
        _thirdDotte(),
      ],
    );
  }

  Widget _firstDotte() {
    late final ProgressType dottePrgressValue;

    if (progress < 1) {
      dottePrgressValue = ProgressType.initial;
    } else {
      dottePrgressValue = ProgressType.completed;
    }

    return _dotte(dottePrgressValue);
  }

  Widget _secondDotte() {
    late final ProgressType dottePrgressValue;

    if (progress < 1) {
      dottePrgressValue = ProgressType.notStarted;
    } else if (progress == 1) {
      dottePrgressValue = ProgressType.initial;
    } else {
      dottePrgressValue = ProgressType.completed;
    }

    return _dotte(dottePrgressValue);
  }

  Widget _thirdDotte() {
    late final ProgressType dottePrgressValue;

    if (progress > 2) {
      dottePrgressValue = ProgressType.completed;
    } else if (progress == 2) {
      dottePrgressValue = ProgressType.initial;
    } else {
      dottePrgressValue = ProgressType.notStarted;
    }

    return _dotte(dottePrgressValue);
  }

  Widget _dotte(
    ProgressType dottePrgressValue,
  ) {
    late final Color dotteColor;

    switch (dottePrgressValue) {
      case ProgressType.initial:
        dotteColor = AppColors.secondary;
        break;
      case ProgressType.completed:
        dotteColor = AppColors.alertGreenColor;
        break;
      case ProgressType.notStarted:
        dotteColor = AppColors.grey300;
        break;
    }

    return AnimatedContainer(
      width: height,
      height: height,
      duration: Durations.transition,
      decoration: BoxDecoration(
        color: dotteColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _lineDashed() {
    return SizedBox(
      width: double.infinity,
      child: CustomPaint(
        painter: DashedShape(dashSpacing: dotteSpacingLine),
      ),
    );
  }
}
