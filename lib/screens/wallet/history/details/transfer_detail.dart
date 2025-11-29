import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/payment/receipt/receipt_action_button.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';

class TransferDetail extends StatelessWidget {
  const TransferDetail({super.key});

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
              child: BillingDetail(
                name: 'Personal Transfer',
                withBtn: false,
                icon: AvatarNetwork(
                  radius: 26,
                  backgroundColor: Colors.white,
                  backgroundImage: ImgApi.avatar[7],
                ),
              ),
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
