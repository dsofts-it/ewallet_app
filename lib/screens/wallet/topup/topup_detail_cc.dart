import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/credit_card_info.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/identity_form.dart';

class TopupDetailCC extends StatelessWidget {
  const TopupDetailCC({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(spacingUnit(2)),
              shrinkWrap: true,
              children: [
                const CreditCardInfo(),
                VSpaceShort(),
                const IdentityForm(),
              ],
            ),
          ),

          /// ACTION BUTTON
          Padding(
            padding: EdgeInsets.only(
              top: spacingUnit(1),
              bottom: spacingUnit(5),
              left: spacingUnit(2),
              right: spacingUnit(2)
            ),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Total Including tax 12%: ', style: ThemeText.paragraph.copyWith(color: colorScheme(context).onSurfaceVariant)),
                  Text('${userAccount.currencySymbol}10.00', style: ThemeText.title2.copyWith(color: colorScheme(context).onInverseSurface, fontWeight: FontWeight.bold),),
                ]),
                SizedBox(height: spacingUnit(1)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ThemeButton.btnBig.merge(ThemeButton.outlinedDefault(context)),
                        child: Text('BACK', style: ThemeText.paragraphBold)
                      ),
                    ),
                    SizedBox(width: spacingUnit(1)),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          confirmDialog(
                            context, title: 'Confim Payment',
                            content: Text('Are you sure want to pay this transaction?', textAlign: TextAlign.center),
                            confirmText: 'Confirm',
                            confirmAction: () {
                              Get.toNamed(AppLink.topupStatus);
                            }
                          );
                        },
                        style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.lock_outline, color: Colors.white),
                          SizedBox(width: 4),
                          Text('SECURE PAY', style: ThemeText.paragraphBold)
                        ])
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}