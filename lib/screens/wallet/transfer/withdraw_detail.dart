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
  'Go to merchant',
  'Scan the barcode or input withdraw code to the payment machine',
  'Please verify the amount. The amount must be same as in the application.',
  'Complete the withdraw process until finish and take your money',
  'Save proof of withdrawal if necessary.',
];

class WithdrawDetail extends StatelessWidget {
  const WithdrawDetail({super.key, this.target = 'atm'});

  final String target;

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
                minutes: 45,
              ),
              format: CountDownTimerFormat.daysHoursMinutes
            ),
            VSpaceShort(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: AlertInfo(type: AlertType.warning, text: 'Please finish your withdrawal before 22 May 2025:17:45'),
            )
          ]),
          const VSpaceShort(),
        
          /// DETAIL BANK AND MERCHANT
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(spacingUnit(2)),
              children: [
                target == 'merchant' ? PaperCard(
                  flat: true,
                  content: Padding(
                    padding: EdgeInsets.all(spacingUnit(2)),
                    child: Column(children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: AssetImage('assets/images/logos/logo13.png'),
                      ),
                      SizedBox(height: spacingUnit(2),),
                      Text('Merchant ABC', style: ThemeText.title2.copyWith(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
                        child: Image.asset('assets/images/dummy/barcode.gif', width: 300,),
                      ),
                      Text('Scan this barcode in Merchant ABC', style: ThemeText.caption,),
                      VSpace(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('Total amount - Admin fee: ', style: ThemeText.paragraph.copyWith(color: colorScheme(context).onSurfaceVariant)),
                        Text('${userAccount.currencySymbol}90', style: ThemeText.title2.copyWith(color: ThemePalette.primaryMain, fontWeight: FontWeight.bold),),
                      ]),
                    ]),
                  )
                ) : Container(),

                target == 'atm' ? PaperCard(
                  flat: true,
                  content: Padding(
                    padding: EdgeInsets.all(spacingUnit(2)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Center(child: Image.asset('assets/images/logos/logo1.png', height: 50,)),
                      const VSpace(),
                      const Text('One Time Payment Code'),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('12345678901', style: ThemeText.title.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(width: spacingUnit(1)),
                        IconButton(icon: const Icon(Icons.copy), onPressed: () {})
                      ]),
                      const VSpaceShort(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('Total amount - Admin fee: ', style: ThemeText.paragraph.copyWith(color: colorScheme(context).onSurfaceVariant)),
                        Text('${userAccount.currencySymbol}110', style: ThemeText.title2.copyWith(color: ThemePalette.primaryMain, fontWeight: FontWeight.bold),),
                      ]),
                    ]),
                  )
                ) : Container(),
                VSpace(),

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
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed(AppLink.history);
                },
                style: ThemeButton.btnBig.merge(ThemeButton.outlinedPrimary(context)),
                child: Text('SEE TRANSACTION HITORY', style: ThemeText.paragraphBold)
              ),
            )
          ),
        ]),
      ),
    );
  }
}