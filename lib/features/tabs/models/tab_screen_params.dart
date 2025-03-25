import 'package:maria_me_envia/core/core.dart';

class TabScreenParams {
  final int initialTabIndex;
  final int initialOrderIndex;

  const TabScreenParams({
    this.initialTabIndex = 0,
    this.initialOrderIndex = 0,
  });

  factory TabScreenParams.sendBox() {
    return const TabScreenParams(
      initialTabIndex: 1,
      initialOrderIndex: Dimens.lengthGenerateOrderTabs - 1,
    );
  }

  factory TabScreenParams.createBox() {
    return const TabScreenParams(
      initialTabIndex: 1,
      initialOrderIndex: 0,
    );
  }
}
