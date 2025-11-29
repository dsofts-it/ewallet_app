import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:ewallet_app/widgets/payment/payment_button.dart';
import 'package:ewallet_app/widgets/wallet/request/request_personal_form.dart';
import 'package:ewallet_app/widgets/wallet/request/request_review.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RequestPersonal extends StatelessWidget {
  const RequestPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          Expanded(
            child: RequestPersonalForm()
          ),
          LineSpace(),
          PaymentButton(
            actionBtn: 'SEND REQUEST',
            onSubmit: () {
              confirmDialog(
                context,
                title: 'Confirmation',
                content: RequestReview(),
                confirmAction: () {
                  Get.toNamed(AppLink.paymentPin);
                },
                confirmText: 'Send Request'
              );
            },
          ),
          VSpace()
        ]),
      ),
    );
  }
}