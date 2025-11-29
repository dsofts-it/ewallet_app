import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:ewallet_app/widgets/payment/payment_button.dart';
import 'package:ewallet_app/widgets/wallet/transfer/transfer_review.dart';
import 'package:ewallet_app/widgets/wallet/transfer/withdraw_form.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String _selected = 'atm';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          Expanded(
            child: WithdrawForm(selectedTarget: _selected, setSelectedTarget: (String val) {
              setState(() {
                _selected = val;
              });
            }),
          ),
          LineSpace(),
          PaymentButton(
            actionBtn: 'WITHDRAW',
            onSubmit: () {
              confirmDialog(
                context,
                title: 'Confirm Withdraw',
                content: TransferReview(),
                confirmAction: () {
                  if(_selected == 'atm') {
                    Get.toNamed(AppLink.withdrawAtmDetail);
                  } else {
                    Get.toNamed(AppLink.withdrawMerchantDetail);
                  }
                },
                confirmText: 'Confirm'
              );
            },
          ),
          VSpace()
        ]),
      ),
    );
  }
}