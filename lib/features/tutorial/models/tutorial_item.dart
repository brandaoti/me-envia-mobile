import 'tutorial_types.dart';

class TutorialItem {
  final List<TutorialStringTypes> listTypes;

  final String? svgPath;
  final String? iconPath;
  final String title;
  final String subtitle;
  final String? message;
  final bool isBigText;

  TutorialItem({
    this.svgPath,
    this.iconPath,
    this.message,
    this.title = '',
    this.subtitle = '',
    this.isBigText = false,
    this.listTypes = const [],
  }) : assert(svgPath == null || iconPath == null);
}
