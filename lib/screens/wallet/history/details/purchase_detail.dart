import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/decorations/zigzag_decoration.dart';
import 'package:ewallet_app/widgets/payment/receipt/receipt_action_button.dart';
import 'package:ewallet_app/widgets/payment/receipt/receipt_list.dart';
import 'package:ewallet_app/widgets/payment/vouchers/voucher_code.dart';
import 'package:flutter/material.dart';

class PurchaseDetail extends StatelessWidget {
  const PurchaseDetail({super.key});

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
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: spacingUnit(1)),
                    decoration: BoxDecoration(
                      color: colorScheme(context).surfaceDim,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spacingUnit(2)),
                      child: Column(
                        children: [
                          /// LOGO
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: getCategory('payment').color.withValues(alpha: 0.5),
                            child: Image.asset(getCategory('payment').image, width: 40,),
                          ),
                          Text('Receipt', style: ThemeText.subtitle),
                          VSpace(),
              
                          /// VOUCHER CODE
                          VoucherCode(),
              
                          /// RECEIPT LIST
                          ReceiptList(),
                        ]
                      ),
                    ),
                  ),
              
                  /// DECORATIONS
                  Positioned(
                    top: 0,
                    child: _zigzag(context)
                  ),
                  Positioned(
                    bottom: 0,
                    child: Transform.flip(
                      flipY: true,
                      child: _zigzag(context)
                    ),
                  ),
                ],
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

  Widget _zigzag(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
      child: ClipPath(
        clipper: ZigzagClipper(),
        child: Container(
          color: colorScheme(context).surfaceDim,
          height: 20,
          width: MediaQuery.of(context).size.width - spacingUnit(4),
        ),
      ),
    );
  }
}
