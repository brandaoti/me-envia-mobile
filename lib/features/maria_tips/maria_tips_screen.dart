import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core.dart';
import 'components/card_maria_tips_component.dart';
import 'maria_tips.dart';

class MariaTipsScreen extends StatefulWidget {
  const MariaTipsScreen({Key? key}) : super(key: key);

  @override
  _MariaTipsScreenState createState() => _MariaTipsScreenState();
}

class _MariaTipsScreenState extends State<MariaTipsScreen> {
  final _controller = Modular.get<MariaTipsController>();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: Modular.to.pop,
        color: AppColors.secondary,
      ),
    );
  }

  Widget _title() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: const AutoSizeText(
        Strings.mariaTipsTitle,
        style: TextStyles.mariaTipsTitle,
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<MariaTipsState>(
      stream: _controller.mariaTipsStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is MariaTipsLoadingState) {
          return const LoadingBody();
        }

        if (states is MariaTipsSucessState) {
          return _listOfMariaTips(states.tips);
        }
        if (states is MariaTipsErrorState) {
          return const LoadingBody();
        }

        return Container();
      },
    );
  }

  Widget _listOfMariaTips(MariaTipsList list) {
    final children = list.map((it) {
      return CardMariaTipsComponent(
        mariaTips: it,
        onTap: () => Modular.to.pushNamed(
          RoutesName.mariaTipsDetailScreen.linkNavigate,
          arguments: it,
        ),
      );
    }).toList();

    return SingleChildScrollView(
      padding: Paddings.bodyHorizontal,
      child: Column(
        children: [
          _title(),
          const VerticalSpacing(30),
          Column(
            children: children,
          )
        ],
      ),
    );
  }
}
