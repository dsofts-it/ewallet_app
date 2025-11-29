import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/utils/col_row.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/payment/payment_button.dart';
import 'package:ewallet_app/widgets/payment/vouchers/voucher_info.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:ewallet_app/widgets/product/billing/purchase_list.dart';
import 'package:ewallet_app/widgets/payment/payment_balance.dart';
import 'package:get/route_manager.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _bottomSheetController;

  void _closeBottomSheet() {
    _bottomSheetController?.close();
  }

  void _showPayBottomSheet() {
    _bottomSheetController = _scaffoldKey.currentState!.showBottomSheet(
      (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: colorScheme(context).surface,
            boxShadow: [ThemeShade.shadeMedium(context)],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(spacingUnit(2)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _closeBottomSheet,
                  child: const GrabberIcon()
                ),
                const VSpaceShort(),
                PaymentBalance(),
                PaymentButton(onSubmit: () {
                  Get.toNamed(AppLink.paymentPin);
                }),
              ],
            ),
          ),
        );
      }
    );
  }

  bool isPersistentBottomSheetClosed() {
    return _bottomSheetController == null;
  }

  @override
  Widget build(BuildContext context) {
    final bool wideScreen = ThemeBreakpoints.smUp(context);
    double screenWidth() {
      if (wideScreen) {
        return ThemeSize.sm;
      } else {
        return MediaQuery.of(context).size.width;
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ThemeSize.sm
          ),
          child: Column(children: [
            VSpace(),
            Expanded(child: Column(children: [
              /// PAYMENT BILLING
              PurchaseList(
                title: 'Payment Mobile Billing',
                icon: CircleAvatar(
                  backgroundColor: colorScheme(context).outline,
                  radius: 28,
                  child: AvatarNetwork(
                    radius: 26,
                    backgroundColor: colorScheme(context).outline,
                    backgroundImage: ImgApi.photo[324],
                    type: 'vendor',
                  ),
                )
              ),
              VSpace(),
            
              /// VOUCHERS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(3)),
                child: VoucherInfo(),
              ),
            ])),
            LineSpace(),
          
            /// CART BUTTON
            ColRow(switched: wideScreen, children: [
              Container(
                width: wideScreen ? screenWidth() * 0.5 : screenWidth(),
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
                child: FilledButton(
                  onPressed: () {
                    confirmDialog(
                      context,
                      title: 'Product has been added to cart',
                      content: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ThemeButton.btnBig.merge(ThemeButton.outlinedDefault(context)),
                          child: Text('BACK TO HOME', style: ThemeText.paragraphBold,)
                        ),
                      ),
                      confirmAction: () {
                        Get.toNamed(AppLink.cart);
                      },
                      confirmText: 'View Cart',
                      cancelText: 'Close'
                    );
                  },
                  style: ThemeButton.btnBig.merge(ThemeButton.tonalSecondary(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_shopping_cart, color: colorScheme(context).onSecondaryContainer, size: 20),
                      SizedBox(width: spacingUnit(1)),
                      Text('ADD TO CART', style: ThemeText.subtitle2,),
                    ],
                  )
                ),
              ),
            
              /// BUTTON PAYMENT
              Container(
                width: wideScreen ? screenWidth() * 0.5 : screenWidth(),
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: wideScreen ? 0 : spacingUnit(2)),
                child: FilledButton(
                  onPressed: () {
                    _showPayBottomSheet();
                  },
                  style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('CONTINUE PAYMENT', style: ThemeText.subtitle2,),
                    ],
                  )
                ),
              ),
            ]),
            
            VSpace()
          ]),
        ),
      ),
    );
  }
}