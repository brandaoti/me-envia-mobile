import 'package:flutter_modular/flutter_modular.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CarrouselComponent extends StatelessWidget {
  final MariaTipsList tips;
  final ValueChanged<int> onPageChanged;

  const CarrouselComponent({
    Key? key,
    required this.onPageChanged,
    this.tips = const <MariaTips>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: _body(),
      width: double.infinity,
    );
  }

  Widget _body() {
    if (tips.isEmpty) {
      return _listItem(
        media: null,
        description: Strings.headerNoTipsTitleText,
      );
    }

    return PageView.builder(
      itemCount: tips.length,
      onPageChanged: onPageChanged,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => _listItem(
        media: tips[index].media,
        description: tips[index].title ?? '',
        onTap: () => Modular.to.pushNamed(
          RoutesName.mariaTipsDetailScreen.linkNavigate,
          arguments: tips[index],
        ),
      ),
    );
  }

  Widget _listItem({
    String? media,
    VoidCallback? onTap,
    required String description,
  }) {
    return InkWell(
      onTap: onTap,
      highlightColor: AppColors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _image(media),
            _illustrationBlur(),
            Positioned(
              left: 16,
              bottom: 30,
              child: _illustrationTitle(description),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(String? path) {
    if (path == null) {
      return SizedBox.expand(
        child: Image.asset(Images.noTips),
      );
    }

    return Container(
      constraints: const BoxConstraints(minWidth: 360),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: NetworkImage(path), fit: BoxFit.cover),
      ),
    );
  }

  Widget _illustrationBlur() {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            AppColors.grey400.withOpacity(0),
            AppColors.grey400.withOpacity(.5),
          ],
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _illustrationTitle(String description) {
    return SizedBox(
      width: 240,
      child: AutoSizeText(
        description,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.noTipsTitleStyle,
      ),
    );
  }
}
