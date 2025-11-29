import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:ewallet_app/widgets/payment/payment_button.dart';
import 'package:ewallet_app/widgets/payment/payment_balance.dart';
import 'package:ewallet_app/widgets/wallet/transfer/transfer_bank_form.dart';
import 'package:ewallet_app/widgets/wallet/transfer/transfer_review.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class TransferBank extends StatelessWidget {
  const TransferBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          Expanded(
            child: TransferBankForm()
          ),
          LineSpace(),
          PaymentBalance(),
          PaymentButton(
            actionBtn: 'TRANSFER',
            onSubmit: () {
              confirmDialog(
                context,
                title: 'Confirm Transfer',
                content: TransferReview(),
                confirmAction: () {
                  Get.toNamed(AppLink.paymentPin);
                },
                confirmText: 'Confirm Transfer'
              );
            },
          ),
          VSpace()
        ]),
      ),
    );
  }
}