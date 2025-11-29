import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/payment_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/alert_info/alert_info.dart';
import 'package:ewallet_app/widgets/app_input/app_input_box.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:ewallet_app/widgets/counter/counter_down.dart';

final List<String> helpGuideList = [
  'Log in to the mobile banking application, internet banking, or ATM.',
  'Select the "Transfer to Virtual Account" menu.',
  'Enter the virtual account number.',
  'Please verify the amount. The amount must be same as in application.',
  'Complete the transfer process until successful. Save proof of transfer if necessary.',
  'Go back to the application, then select the "Confirm Payment" button.'
];

class TopupDetailVac extends StatelessWidget {
  const TopupDetailVac({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          const Column(children: [
            /// TIMER
            VSpace(),
            Text('Time left:'),
            CounterDown(
              duration: Duration(
                days: 0,
                hours: 23,
                minutes: 30,
              ),
              format: CountDownTimerFormat.daysHoursMinutes
            ),
            VSpaceShort(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: AlertInfo(type: AlertType.warning, text: 'Please finish your payment before 22 May 2025:17:45'),
            )
          ]),
          const VSpaceShort(),
        
          /// DETAIL BANK ACCOUNT
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(spacingUnit(2)),
              children: [
                PaperCard(
                  flat: true,
                  content: Padding(
                    padding: EdgeInsets.all(spacingUnit(2)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Center(child: Image.asset('assets/images/logos/logo2.png', height: 50,)),
                      const VSpace(),
                      const Text('Virtual Account Number'),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('098765432112345', style: ThemeText.title.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(width: spacingUnit(1)),
                        IconButton(icon: const Icon(Icons.copy), onPressed: () {})
                      ]),
                      const VSpaceShort(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('Total amount + Admin fee: ', style: ThemeText.paragraph.copyWith(color: colorScheme(context).onSurfaceVariant)),
                        Text('${userAccount.currencySymbol}110', style: ThemeText.title2.copyWith(color: ThemePalette.primaryMain, fontWeight: FontWeight.bold),),
                      ]),
                    ]),
                  )
                ),
                const VSpace(),
                AppInputBox(content: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Icon(Icons.help_outline, color: ThemePalette.secondaryMain),
                  title: Text('Need guide for this transfer method?', style: ThemeText.paragraph,),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showModalBottomSheet<dynamic>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            PaymentGuide(guideList: helpGuideList)
                          ]
                        );
                      }
                    );
                  },
                ))
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('By continuing, you agree with the', style: ThemeText.caption,),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppLink.terms);
                    },
                    child: Text(' Terms and Conditions', style: ThemeText.caption.copyWith(color: ThemePalette.primaryMain))
                  ),
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
                          Get.toNamed(AppLink.topupStatus);
                        },
                        style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                        child: Text('CONFIRM TRANSFER', style: ThemeText.paragraphBold)
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