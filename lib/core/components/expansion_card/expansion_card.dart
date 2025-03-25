import 'package:flutter/material.dart';

import 'package:maria_me_envia/core/values/values.dart';

class ExpansionCard extends StatefulWidget {
  final String title;
  final String body;

  const ExpansionCard({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  bool _isExpanded = false;

  void _onExpansionChanged(bool value) {
    setState(() {
      _isExpanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        Visibility(
          child: _child(),
          visible: _isExpanded,
        ),
      ],
    );
  }

  Widget _header() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionTile(
        title: _headerTitle(),
        textColor: AppColors.white,
        iconColor: AppColors.whiteDefault,
        backgroundColor: AppColors.secondary,
        onExpansionChanged: _onExpansionChanged,
        collapsedTextColor: AppColors.whiteDefault,
        collapsedIconColor: AppColors.whiteDefault,
        collapsedBackgroundColor: AppColors.secondary,
        children: [
          _emptyChild(),
        ],
      ),
    );
  }

  Widget _child() {
    return Padding(
      padding: Paddings.expansiontionTitle,
      child: Text(
        widget.body,
        style: TextStyles.expansionTileContentStyle,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _emptyChild() {
    return const SizedBox.shrink();
  }

  Widget _headerTitle() {
    return Padding(
      child: Text(widget.title),
      padding: Paddings.expansiontion,
    );
  }
}
