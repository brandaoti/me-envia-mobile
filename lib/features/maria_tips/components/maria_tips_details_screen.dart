import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../general_information/components/screen_header.dart';

class MariaTipsDetaisScreen extends StatelessWidget {
  final MariaTips mariaTips;

  const MariaTipsDetaisScreen({
    Key? key,
    required this.mariaTips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SreenHeader(
            media: mariaTips.media,
          ),
          const VerticalSpacing(24),
          _content(),
        ],
      ),
    );
  }

  Widget _content() {
    return Padding(
      padding: Paddings.bodyHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          const VerticalSpacing(8),
          _subtitle(),
          const VerticalSpacing(24),
          _description(),
          const VerticalSpacing(38),
          _borderLessButton(),
        ],
      ),
    );
  }

  Widget _title() {
    return AutoSizeText(
      mariaTips.title,
      style: TextStyles.learnMoreTitleStyle,
    );
  }

  Widget _subtitle() {
    return AutoSizeText(
      mariaTips.createdAt.toMonthAndDay,
      style: TextStyles.whoIsMariaSubtitle.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _description() {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        mariaTips.description ?? '',
        minFontSize: 14,
        textAlign: TextAlign.left,
        style: TextStyles.mariaTipsTitle.copyWith(
          height: 1.4,
          fontSize: 18,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _borderLessButton() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: BordLessButton(
        title: Strings.checkpromotions,
        onPressed: () => Helper.launchTo(
          mariaTips.link ?? '',
          useWebView: true,
        ),
      ),
    );
  }
}
