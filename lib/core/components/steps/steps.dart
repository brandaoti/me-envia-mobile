import 'package:flutter/material.dart';
import 'package:maria_me_envia/core/values/values.dart';

class StepsWidget extends StatelessWidget {
  final int selectedIndex;
  final int lengthStepsGenerated;

  const StepsWidget({
    Key? key,
    this.selectedIndex = 0,
    this.lengthStepsGenerated = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List<Widget>.generate(lengthStepsGenerated, (int index) {
        final bool isActive = index == selectedIndex;
        return _stepsAnimated(isActive);
      }),
    );
  }

  Widget _stepsAnimated(bool isActive) {
    return AnimatedContainer(
      height: 8,
      width: isActive ? 27 : 8,
      duration: Durations.transition,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: Decorations.stepsDecoration(isActive),
    );
  }
}
