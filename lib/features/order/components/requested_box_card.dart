import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

typedef HandlePressed = void Function(Package);

class RequestedBoxCard extends StatelessWidget {
  final bool isPayment;
  final Package package;
  final HandlePressed onPressed;

  const RequestedBoxCard({
    Key? key,
    required this.package,
    this.isPayment = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _body(),
      width: double.infinity,
      alignment: Alignment.topCenter,
      padding: Paddings.listTilePadding,
      decoration: Decorations.cardOrderItem(false),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _quantityPackageItems(),
            Expanded(
              child: _description(),
            ),
            Visibility(
              visible: isPayment,
              child: _paybutton(),
            )
          ],
        ),
        Visibility(
          child: _paymentRefused(),
          visible: isPayment &&
              package.packageStatus == PackageStatus.paymentRefused,
        ),
      ],
    );
  }

  Widget _paymentRefused() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: AutoSizeText(
        Strings.paymentRefused,
        style: TextStyles.mariaTipsTitle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.alertRedColor,
        ),
      ),
    );
  }

  Widget _quantityPackageItems() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _quantity(
          child: SvgPicture.asset(Svgs.iconBox, color: AppColors.secondary),
        ),
        Positioned(
          bottom: 0,
          right: -5,
          child: _quantity(
            size: 20,
            padding: 4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteDefault,
            ),
            child: AutoSizeText(
              package.totalItems.toString(),
              textAlign: TextAlign.center,
              style: TextStyles.boxCountStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget _quantity({
    double size = 56,
    double padding = 12,
    required Widget child,
    Decoration? decoration,
  }) {
    return Container(
      width: size,
      height: size,
      child: child,
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      decoration: decoration ?? Decorations.boxCarRequestedBox,
    );
  }

  Widget _description() {
    String amountToPaymentOrDeclaredTotal;

    if (isPayment) {
      final shippingFeeValue = package.shippingFee?.byReal();
      amountToPaymentOrDeclaredTotal = Strings.boxDeclarationValue(
        shippingFeeValue?.formatterMoneyToBrasilian ?? '',
        isAmountoPay: true,
      );
    } else {
      amountToPaymentOrDeclaredTotal = Strings.boxDeclarationValue(
        package.declaredTotal?.formatterMoneyToBrasilian ?? '',
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            Strings.boxWithId(package.id.substring(0, 5)),
            style: TextStyles.mariaTipsTitle.copyWith(
              fontSize: 18,
            ),
          ),
          const VerticalSpacing(8),
          _amountToPay(
            text: amountToPaymentOrDeclaredTotal,
          ),
          Visibility(
            child: _paymentStatus(),
            visible: package.packageStatus ==
                PackageStatus.paymentSubjectToConfirmation,
          )
        ],
      ),
    );
  }

  Widget _paymentStatus() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: _amountToPay(text: Strings.awaitPaymentConfirmation),
    );
  }

  Widget _amountToPay({
    required String text,
    IconData icon = Icons.attach_money_rounded,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
        Expanded(
          child: _declarationValue(text),
        ),
      ],
    );
  }

  Widget _declarationValue(String text) {
    return AutoSizeText(
      text,
      maxLines: 2,
      textAlign: TextAlign.left,
      style: TextStyles.declarationValue,
    );
  }

  Widget _paybutton() {
    final recused = package.packageStatus == PackageStatus.paymentRefused;
    return Visibility(
      visible: package.hasPaymentPending,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 40,
          width: recused ? 85 : 80,
          child: DefaultButton(
            isValid: true,
            onPressed: () => onPressed(package),
            title:
                recused ? Strings.forgotPasswordButtonTitleSend : Strings.pay,
          ),
        ),
      ),
    );
  }
}
