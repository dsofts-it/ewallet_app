import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/widgets/payment/payment_button.dart';
import 'package:ewallet_app/widgets/payment/vouchers/voucher_info.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/payment/cart_list.dart';
import 'package:ewallet_app/widgets/payment/payment_balance.dart';
import 'package:get/route_manager.dart';

class PaymentCart extends StatelessWidget {
  const PaymentCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          Expanded(child: CartList()),
          VSpaceShort(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
            child: VoucherInfo(),
          ),
          LineSpace(),
          PaymentBalance(),
          SizedBox(height: spacingUnit(1)),
          PaymentButton(onSubmit: () {
            Get.toNamed(AppLink.paymentPin);
          },),
          VSpace()
        ]),
      ),
    );
  }
}