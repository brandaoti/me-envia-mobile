import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../types/package_type.dart';
import '../../values/values.dart';
import '../../types/package_step.dart';

class DeliverySteps extends StatelessWidget {
  final PackageType type;
  final PackageStep steps;

  final double height;
  final double width;
  final double dotSize;

  const DeliverySteps({
    Key? key,
    this.width = 166,
    this.height = 100,
    this.dotSize = 24,
    this.type = PackageType.success,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Padding(
            child: _backgroundStepLine(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          _listOfDots(),
        ],
      ),
    );
  }

  Widget _backgroundStepLine() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) => _dotLine(index + 1)),
      ),
    );
  }

  Widget _dotLine(int lineNumber) {
    return Expanded(
      child: Container(
        height: 2,
        color: _lineColor(lineNumber),
      ),
    );
  }

  Color _lineColor(int lineNumber) {
    int linesToPaint = 0;

    switch (steps) {
      case PackageStep.notSend:
        linesToPaint = 0;
        break;
      case PackageStep.send:
        linesToPaint = 0;
        break;
      case PackageStep.arrivedInbrazil:
        linesToPaint = 1;
        break;
      case PackageStep.inTransit:
        linesToPaint = 2;
        break;
      case PackageStep.delivered:
        linesToPaint = 3;
        break;
    }

    if (lineNumber <= linesToPaint) {
      return AppColors.alertGreenColor;
    } else {
      return AppColors.grey400;
    }
  }

  Widget _listOfDots() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) => _stepDot(type, index + 1)),
      ),
    );
  }

  Widget _stepDot(PackageType type, int stepNumber) {
    Color iconColor = (type == PackageType.success)
        ? AppColors.alertGreenColor
        : AppColors.alertYellowColor;

    switch (stepNumber) {
      case 1:
        switch (steps) {
          case PackageStep.notSend:
            return _stepDotItem(
              useIcon: true,
            );
          case PackageStep.send:
            return _stepDotItem(
              useIcon: true,
              color: iconColor,
            );
          case PackageStep.arrivedInbrazil:
            return _stepDotItem(
              color: AppColors.alertGreenColor,
            );
          case PackageStep.inTransit:
            return _stepDotItem(
              color: AppColors.alertGreenColor,
            );
          case PackageStep.delivered:
            return _stepDotItem(
              color: AppColors.alertGreenColor,
            );
        }
      case 2:
        switch (steps) {
          case PackageStep.notSend:
            return _stepDotItem();
          case PackageStep.send:
            return _stepDotItem();
          case PackageStep.arrivedInbrazil:
            return _stepDotItem(
              useIcon: true,
              color: iconColor,
            );
          case PackageStep.inTransit:
            return _stepDotItem(
              color: AppColors.alertGreenColor,
            );
          case PackageStep.delivered:
            return _stepDotItem(
              color: AppColors.alertGreenColor,
            );
        }
      case 3:
        switch (steps) {
          case PackageStep.notSend:
            return _stepDotItem();
          case PackageStep.send:
            return _stepDotItem();
          case PackageStep.arrivedInbrazil:
            return _stepDotItem();
          case PackageStep.inTransit:
            return _stepDotItem(
              useIcon: true,
              color: iconColor,
            );
          case PackageStep.delivered:
            return _stepDotItem(
              color: AppColors.alertGreenColor,
            );
        }
      case 4:
        switch (steps) {
          case PackageStep.notSend:
            return _stepDotItem();
          case PackageStep.send:
            return _stepDotItem();
          case PackageStep.arrivedInbrazil:
            return _stepDotItem();
          case PackageStep.inTransit:
            return _stepDotItem();
          case PackageStep.delivered:
            return _stepDotItem(
              color: iconColor,
              useIcon: true,
            );
        }
      default:
        return _stepDotItem(useIcon: true);
    }
  }

  Widget _stepDotItem({
    bool useIcon = false,
    Color color = AppColors.grey400,
  }) {
    return SizedBox(
      width: useIcon ? dotSize : (dotSize / 2),
      height: useIcon ? dotSize : (dotSize / 2),
      child: CircleAvatar(
        backgroundColor: color,
        radius: useIcon ? dotSize : (dotSize / 4),
        child: Visibility(
          visible: useIcon,
          child: _dotIcon(),
        ),
      ),
    );
  }

  Widget _dotIcon() {
    return Padding(
      padding: const EdgeInsets.all(4.1),
      child: SvgPicture.asset(Svgs.planeIcon),
    );
  }
}
