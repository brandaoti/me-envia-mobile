import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class DeleteConfirmation {
  final String message;
  final BuildContext context;
  final VoidCallback? onConfirm;
  final Stream<DeleteAccountState> statesStream;

  const DeleteConfirmation({
    this.onConfirm,
    required this.message,
    required this.context,
    required this.statesStream,
  });

  void show() {
    showModalBottomSheet(
      context: context,
      builder: _builder,
      isDismissible: false,
      shape: Decorations.dialogs,
    );
  }

  Widget _builder(BuildContext context) {
    return SafeArea(
      child: Container(
        child: _body(),
        width: double.infinity,
        padding: Paddings.horizontal,
      ),
    );
  }

  Widget _builderState({required BuilderState<DeleteAccountState> builder}) {
    return StreamBuilder<DeleteAccountState>(
      stream: statesStream,
      builder: (context, snapshot) => builder(snapshot.data),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const VerticalSpacing(28),
          _illustration(),
          const VerticalSpacing(28),
          _message(),
          const VerticalSpacing(28),
          _actionsButton(),
          const VerticalSpacing(24),
        ],
      ),
    );
  }

  Widget _illustration() {
    const size = Dimens.dialogIllustration;
    return SvgPicture.asset(Svgs.warningRed, height: size, width: size);
  }

  Widget _message() {
    return _builderState(
      builder: (DeleteAccountState? states) {
        String? errorMessage;
        if (states is DeleteAccountErrorState) {
          errorMessage = states.message;
        }

        return AutoSizeText(
          errorMessage ?? message,
          textAlign: TextAlign.center,
          style: TextStyles.resgitrationAccepTermOfUse.copyWith(
            fontSize: 22,
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }

  Widget _actionsButton() {
    return _builderState(
      builder: (DeleteAccountState? states) {
        if (states is DeleteAccountLoadingState) {
          return _isLoading();
        }

        return Column(
          children: [
            _confirmButon(),
            const VerticalSpacing(16),
            _cancelButton(),
          ],
        );
      },
    );
  }

  Widget _isLoading() {
    return const SizedBox(
      width: 30,
      height: 30,
      child: Loading(
        color: AppColors.primary,
      ),
    );
  }

  Widget _confirmButon() {
    return _builderState(
      builder: (DeleteAccountState? states) {
        final hasError = states is DeleteAccountErrorState;

        if (states is DeleteAccountSuccessState) {
          _close();
        }

        return SizedBox(
          width: double.infinity,
          height: Dimens.buttonHeightSmall,
          child: DefaultButton(
            isValid: true,
            onPressed: onConfirm,
            title: hasError ? Strings.tryAgain : Strings.yes,
          ),
        );
      },
    );
  }

  Widget _cancelButton() {
    return SizedBox(
      width: double.infinity,
      height: Dimens.buttonHeightSmall,
      child: RoundedButton(
        isValid: true,
        title: Strings.no,
        onPressed: _close,
      ),
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }
}
