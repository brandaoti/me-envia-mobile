import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../states/requested_box_states.dart';
import '../../components/components.dart';
import '../../../../core/core.dart';

import 'requested_boxes_controller.dart';

class RequestedBoxes extends StatefulWidget {
  const RequestedBoxes({Key? key}) : super(key: key);

  @override
  _RequestedBoxesState createState() => _RequestedBoxesState();
}

class _RequestedBoxesState extends State<RequestedBoxes> {
  final _controller = Modular.get<RequestedBoxController>();

  @override
  void initState() {
    _controller.init(PackageSection.created);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const VerticalSpacing(24),
          _sectionsHeader(),
          const VerticalSpacing(40),
          _body(),
          const VerticalSpacing(40),
        ],
      ),
    );
  }

  Widget _sectionsHeader({
    String title = Strings.trackYourBox,
    String buttonText = Strings.streetInputLabelText,
  }) {
    final style = TextStyles.orderBoxProduct.copyWith(
      height: 1.2,
      fontSize: 24,
    );

    return Row(
      children: [
        SizedBox(
          width: 170,
          child: AutoSizeText(title, style: style),
        ),
        const Spacer(),
        _addressButton(buttonText),
      ],
    );
  }

  Widget _addressButton(String text) {
    return SizedBox(
      width: 85,
      height: 40,
      child: RoundedButton(
        title: text,
        isValid: true,
        onPressed: () => Modular.to.pushNamed(
          RoutesName.addressInformation.linkNavigate,
        ),
        padding: const EdgeInsets.all(12),
        textStyle: TextStyles.roundedButton(true).copyWith(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<RequestedBoxState>(
      stream: _controller.requestedBoxStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is RequestedBoxLoadingState) {
          return const Loading(useContainerBox: true);
        }

        if (states is RequestedBoxErrorState) {
          return const ErrorText(
            height: null,
          );
        }

        if (states is RequestedBoxSucessState) {
          return _content(states.pack);
        }

        return Container();
      },
    );
  }

  Widget _content(List<Package> pack) {
    return Visibility(
      visible: pack.isNotEmpty,
      replacement: _noItems(),
      child: Column(
        children: pack.map((e) => _requestCard(e)).toList(),
      ),
    );
  }

  Widget _noItems() {
    return const ErrorText(
      height: null,
      message: Strings.noRequestBox,
    );
  }

  Widget _requestCard(Package package) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: RequestedBoxCard(
        package: package,
        onPressed: (package) => print(package.id),
      ),
    );
  }
}
