import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class EditDone extends StatelessWidget {
  const EditDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _svgPicture(),
          const VerticalSpacing(60),
          _text(
            title: Strings.sectionProfileFirstText,
            style: TextStyles.sectionProfileFirstStyle,
          ),
          const VerticalSpacing(16),
          _text(
            title: Strings.sectionProfileSecondText,
            style: TextStyles.sectionProfileSecondStyle,
          ),
        ],
      ),
    );
  }

  Widget _svgPicture() {
    return SvgPicture.asset(
      Svgs.forgotPassword02,
      height: 370,
      width: 300,
    );
  }

  Widget _text({
    String title = '',
    TextStyle? style,
  }) {
    return AutoSizeText(
      title,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
