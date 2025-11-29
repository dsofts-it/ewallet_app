import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/widgets/app_input/app_input_box.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/payment_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';

final List<String> helpGuideList = [
  'Go to merchant',
  'Scan the barcode to the payment machine',
  'Pay the amount and it must be same as in application.',
  'Complete the payment process until successful. Save proof of receipt if necessary.',
  'Go back to the application, then select the "Confirm Payment" button.'
];

class TopupDetailMerchant extends StatelessWidget {
  const TopupDetailMerchant({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(spacingUnit(2)),
            child: SizedBox(
              width: double.infinity,
              child: PaperCard(
                flat: true,
                content: Padding(
                  padding: EdgeInsets.all(spacingUnit(2)),
                  child: Column(children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/logos/logo11.jpg'),
                      backgroundColor: Colors.grey[200],
                    ),
                    SizedBox(height: spacingUnit(2),),
                    Text('Merchant ABC', style: ThemeText.title2.copyWith(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
                      child: Image.asset('assets/images/dummy/barcode.gif', width: 300,),
                    ),
                    Text('Submit this barcode in Merchant ABC', style: ThemeText.caption,)
                  ]),
                )
              ),
            ),
          ),
          Expanded(
            child: ListView(children: [
              ListTile(
                leading: Icon(Icons.shopping_bag_outlined),
                title: Text('Billing Ammount:'),
                trailing: Text('${userAccount.currencySymbol}100.00', style: ThemeText.paragraph,),
              ),
              const LineList(),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Admin Fee:'),
                trailing: Text('${userAccount.currencySymbol}1.0', style: ThemeText.paragraph,),
              ),
              const LineList(),
              ListTile(
                title: Text('Total:', style: ThemeText.title2.copyWith(fontWeight: FontWeight.bold),),
                trailing: Text('${userAccount.currencySymbol}101.0', style: ThemeText.title2.copyWith(fontWeight: FontWeight.bold, color: ThemePalette.primaryMain),),
              ),
              VSpaceShort(),
              Padding(
                padding: EdgeInsets.all(spacingUnit(2)),
                child: AppInputBox(content: ListTile(
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
                )),
              )
            ])
          ),
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