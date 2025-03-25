import 'package:flutter/material.dart';

import '../../core/core.dart';

class PicturesScreen extends StatefulWidget {
  final List<String> pictures;

  const PicturesScreen({
    Key? key,
    required this.pictures,
  }) : super(key: key);

  @override
  _PicturesScreenState createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<PicturesScreen> {
  int _currentPageIndex = 0;

  void _onPageChanged(int page) {
    setState(() => _currentPageIndex = page);
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
      leading: const BackButton(color: AppColors.secondary),
    );
  }

  Widget _body() {
    return SizedBox(
      width: double.infinity,
      height: context.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 6,
            child: _generatedPicturesListWidget(),
          ),
          Expanded(
            flex: 2,
            child: _steps(),
          ),
        ],
      ),
    );
  }

  Widget _generatedPicturesListWidget() {
    return PageView.builder(
      onPageChanged: _onPageChanged,
      itemCount: widget.pictures.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(widget.pictures[index], fit: BoxFit.contain),
        );
      },
    );
  }

  Widget _steps() {
    return Visibility(
      visible: widget.pictures.length > 1,
      child: StepsWidget(
        selectedIndex: _currentPageIndex,
        lengthStepsGenerated: widget.pictures.length,
      ),
    );
  }
}
