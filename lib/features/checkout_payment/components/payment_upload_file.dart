import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/values/values.dart';
import '../states/open_proof_of_payment_state.dart';

class PaymentUploadFile extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Stream<OpenProofOfPaymentState> stream;

  const PaymentUploadFile({
    Key? key,
    required this.stream,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OpenProofOfPaymentState>(
      stream: stream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        final mappinColorState = {
          OpenProofOfPaymentInitalState: AppColors.secondary,
          OpenProofOfPaymentSucessState: AppColors.alertGreenColor,
          OpenProofOfPaymentErrorState: AppColors.alertRedColor,
        };

        return InkWell(
          child: DottedBorder(
            child: _body(states),
            dashPattern: const [8],
            borderType: BorderType.RRect,
            radius: const Radius.circular(20),
            color: mappinColorState[states.runtimeType] ?? AppColors.secondary,
          ),
          onTap: isLoading ? () {} : onPressed,
        );
      },
    );
  }

  Widget _body(OpenProofOfPaymentState? states) {
    return Container(
      height: 198,
      width: double.infinity,
      alignment: Alignment.center,
      child: _chooseContentWithOpenProofOfPaymentState(states),
    );
  }

  Widget _chooseContentWithOpenProofOfPaymentState(
    OpenProofOfPaymentState? states,
  ) {
    if (states == null || states is OpenProofOfPaymentInitalState) {
      return _initialState();
    }

    if (states is OpenProofOfPaymentSucessState) {
      return _ortherState(
        message: states.fileName,
        color: AppColors.alertGreenColor,
        icon: Icons.check_rounded,
      );
    }

    if (states is OpenProofOfPaymentErrorState) {
      return _ortherState(message: states.message);
    }

    return Container();
  }

  Widget _initialState() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          Svgs.iconFile,
          color: AppColors.secondary,
          width: 64,
          height: 64,
        ),
        const HorizontalSpacing(16),
        ConstrainedBox(
          constraints: Sizes.paymentpackageList,
          child: AutoSizeText(
            Strings.paymentFileUploadTitle,
            style: TextStyles.modalConfirmOrderTitleStyle.copyWith(
              height: 1.6,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }

  Widget _ortherState({
    IconData icon = Icons.close_rounded,
    Color color = AppColors.alertRedColor,
    String message = Strings.paymentFileUploadError,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
          ),
          child: Icon(icon, color: color),
        ),
        const HorizontalSpacing(16),
        ConstrainedBox(
          constraints: Sizes.paymentpackageList,
          child: AutoSizeText(
            message,
            style: TextStyles.modalConfirmOrderTitleStyle.copyWith(
              height: 1.6,
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
