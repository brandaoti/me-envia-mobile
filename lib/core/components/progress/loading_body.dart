import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../buttons/bordless_button.dart';
import '../../values/values.dart';
import 'loading.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Loading(
            height: 60,
          ),
          const VerticalSpacing(24),
          BordLessButton(
            onPressed: Modular.to.pop,
            title: Strings.returnButtonText,
          ),
        ],
      ),
    );
  }
}
