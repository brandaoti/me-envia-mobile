import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

class SendBoxDescription extends StatelessWidget {
  final int maxLines;
  final String? status;
  final bool isExpanded;
  final bool titleVisible;
  final String packageId;
  final bool stepsVisible;
  final PackageType? type;
  final PackageStep? steps;
  final String? trackingCode;
  final String? lastPackageUpdateLocation;

  const SendBoxDescription({
    Key? key,
    this.maxLines = 1,
    required this.type,
    required this.steps,
    required this.status,
    required this.packageId,
    this.stepsVisible = true,
    this.titleVisible = true,
    required this.isExpanded,
    required this.trackingCode,
    required this.lastPackageUpdateLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const EdgeInsets paddingLeft = EdgeInsets.only(left: 3);
    return Padding(
      padding: Paddings.sendBoxCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            child: _boxTitle(),
            padding: paddingLeft,
          ),
          const VerticalSpacing(8),
          _lastUpdatedLocation(),
          const VerticalSpacing(8),
          _trackingCodeLocation(),
          Padding(
            padding: paddingLeft,
            child: _packageStatus(),
          ),
          const VerticalSpacing(8),
          Padding(
            padding: paddingLeft,
            child: _deliverySteps(),
          ),
        ],
      ),
    );
  }

  Widget _boxTitle() {
    return Visibility(
      visible: titleVisible,
      child: AutoSizeText(
        Strings.boxWithId(packageId.substring(0, 4)),
        maxLines: 1,
        minFontSize: 16,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.boxTitleStyle,
      ),
    );
  }

  Widget _lastUpdatedLocation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.pin_drop,
          size: 16,
          color: AppColors.secondaryLightText,
        ),
        const HorizontalSpacing(4),
        Expanded(
          child: _lastPackageUpdateLocation(),
        ),
      ],
    );
  }

  Widget _lastPackageUpdateLocation() {
    return AutoSizeText(
      lastPackageUpdateLocation ?? Strings.awaitPackageLastLocation,
      maxLines: 2,
      minFontSize: 12,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.textLocationStyle,
    );
  }

  Widget _trackingCodeLocation() {
    if ((trackingCode ?? '').isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AutoSizeText(
        trackingCode!,
        maxLines: 1,
        minFontSize: 12,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.textLocationStyle,
      ),
    );
  }

  Widget _packageStatus() {
    return AutoSizeText(
      status ?? '',
      minFontSize: 12,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.textLocationStyle.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _deliverySteps() {
    return Visibility(
      visible: stepsVisible,
      child: DeliverySteps(
        width: 120,
        height: 20,
        type: type ?? PackageType.warning,
        steps: steps ?? PackageStep.notSend,
      ),
    );
  }
}
