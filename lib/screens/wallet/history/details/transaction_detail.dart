import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/payment/receipt/receipt_action_button.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:flutter/material.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(
          children: [
            VSpaceShort(),
            Expanded(
              child: BillingDetail(name: 'Transaction', withBtn: false,),
            ),
            /// OTHER ACTIONS BUTTONS
            const VSpaceShort(),
            ReceiptActionButton(),
        
            /// BUTTON
            ReceiptButton(),
            const VSpace()
          ],
        ),
      ),
    );
  }
}
