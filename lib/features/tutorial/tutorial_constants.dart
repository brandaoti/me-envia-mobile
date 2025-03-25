import 'package:maria_me_envia/core/values/values.dart';

import 'models/tutorial_item.dart';
import 'models/tutorial_types.dart';

final List<TutorialItem> toturialItemsModel = [
  TutorialItem(
    title: Strings.tutorialTitleFirstStepText,
    svgPath: Svgs.tutorialFirstStep,
    listTypes: [
      const TutorialStringTypes(
        title: Strings.tutorialSubtitleFirstStepText,
      ),
    ],
  ),
  TutorialItem(
    title: Strings.tutorialTitleSecondtepText,
    iconPath: Images.tutorialSecondStep,
    listTypes: [
      const TutorialStringTypes(
        title: Strings.tutorialSubtitleSecondStepText,
      ),
    ],
  ),
  TutorialItem(
    title: Strings.tutorialTitleThirdStepText,
    iconPath: Images.tutorialThirdStep,
    listTypes: [
      const TutorialStringTypes(
        title: Strings.tutorialSubtitleThirdStepText,
      ),
    ],
  ),
  TutorialItem(
    title: Strings.tutorialTitleFourthStepText,
    iconPath: Images.tutorialFourthStep,
    listTypes: [
      TutorialStringTypes(
        title: Strings.tutorialSubtitleFourthStepText[0],
      ),
      TutorialStringTypes(
        subtitle: Strings.tutorialSubtitleFourthStepText[1],
        isTextBold: true,
      ),
      TutorialStringTypes(
        subtitle: Strings.tutorialSubtitleFourthStepText[2],
      ),
    ],
  ),
  TutorialItem(
    isBigText: true,
    svgPath: Svgs.tutorialFifthStep,
    title: Strings.tutorialTitleFifthStepText,
    listTypes: [
      TutorialStringTypes(
        title: Strings.tutorialSubtitleFifthStepText[0],
      ),
      TutorialStringTypes(
        subtitle: Strings.tutorialSubtitleFifthStepText[1],
        isTextBold: true,
      ),
      TutorialStringTypes(
        subtitle: Strings.tutorialSubtitleFifthStepText[2],
      ),
    ],
  ),
  TutorialItem(
    title: Strings.tutorialTitleSixthStepText,
    iconPath: Images.tutorialSixthStep,
    listTypes: [
      TutorialStringTypes(
        title: Strings.tutorialSubtitleSixthStepText[0],
      ),
    ],
  ),
  TutorialItem(
    title: Strings.tutorialTitleSeventhStepText,
    svgPath: Svgs.tutorialSeventhStep,
    listTypes: [
      TutorialStringTypes(
        title: Strings.tutorialSubtitleSeventhStepText[0],
      ),
    ],
    message: Strings.tutorialSubtitleSeventhStepText[1],
  ),
];
