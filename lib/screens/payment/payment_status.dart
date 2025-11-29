import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/widgets/decorations/zigzag_decoration.dart';
import 'package:ewallet_app/widgets/payment/receipt/receipt_action_button.dart';
import 'package:ewallet_app/widgets/payment/receipt/receipt_list.dart';
import 'package:ewallet_app/widgets/payment/vouchers/voucher_code.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';

class PaymentStatus extends StatelessWidget {
  const PaymentStatus({super.key});

  Color statusColor(String status) {
    switch(status) {
      case 'error':
        return Colors.red;
      case 'waiting':
        return Colors.orangeAccent;
      case 'success':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  IconData statusIcon(String status) {
    switch(status) {
      case 'error':
        return Icons.warning;
      case 'waiting':
        return Icons.access_time;
      case 'success':
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool wideScreen = ThemeBreakpoints.smUp(context);

    return Scaffold(
      backgroundColor: !isDark ? lighten(ThemePalette.primaryLight, 0.15) : null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(statusIcon('success'), size: 24, color: statusColor('success')),
          SizedBox(width: 4),
          Text('Payment Success', style: ThemeText.subtitle)
        ]),
      ),
      body: Column(children: [
        Expanded(
          /// LIST DETAIL
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ThemeSize.sm
              ),
              child: Column(
                children: [
                  VSpaceShort(),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: wideScreen ? 0 : spacingUnit(2), vertical: spacingUnit(1)),
                        decoration: BoxDecoration(
                          color: isDark ? colorScheme(context).surfaceDim: ThemePalette.paperLight,
                          boxShadow: [
                            BoxShadow(
                              color:Colors.black.withValues(alpha: 0.1),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: const Offset(0, 0),
                            )
                          ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(spacingUnit(2)),
                          child: Column(
                            children: [
                              /// LOGO
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: getCategory('payment').color.withValues(alpha: 0.25),
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
                        left: 0,
                        child: _zigzag(context)
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Transform.flip(
                          flipY: true,
                          child: _zigzag(context)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        /// OTHER ACTIONS BUTTONS
        const VSpaceShort(),
        ReceiptActionButton(),

        /// BUTTON
        Center(child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ThemeSize.sm
          ),
          child: ReceiptButton()
        )),
        const VSpace()
      ])
    );
  }

  Widget _zigzag(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
      child: ClipPath(
        clipper: ZigzagClipper(),
        child: Container(
          color: isDark ? colorScheme(context).surfaceDim : ThemePalette.paperLight,
          height: 20,
          width: MediaQuery.of(context).size.width - spacingUnit(4),
        ),
      ),
    );
  }
}
