import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/payment_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_input_box.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/bank_acc_form.dart';

final List<String> helpGuideList = [
  'Log in to the mobile banking application, internet banking, or ATM.',
  'Select the "Transfer to Bank" menu.',
  'Finde and Select "Lorem Bank".',
  'Enter the account number.',
  'Enter the nominal amount.',
  'Please verify the amount. The amount must be same as in application.',
  'Complete the transfer process until successful. Save proof of transfer if necessary.',
  'Go back to the application, then select the "Confirm Payment" button.'
];

class TopupDetailTransfer extends StatelessWidget {
  const TopupDetailTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
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
                    child: Column(children: [
                      Text('${userAccount.currencySymbol}101.00', style: ThemeText.title.copyWith(color: ThemePalette.primaryMain, fontWeight: FontWeight.bold)),
                      const Text('Please transfer the amount above to'),
                      Image.asset('assets/images/logos/logo1.png', height: 50,),
                      const VSpaceShort(),
                      ListTile(
                        title: Text('Account Name', style: ThemeText.caption,),
                        subtitle: Text('Bank Lorem Ipsum', style: ThemeText.subtitle2.copyWith(fontWeight: FontWeight.bold),),
                      ),
                      const LineList(),
                      ListTile(
                        title: Text('Account Number', style: ThemeText.caption,),
                        subtitle: Text('1234567890', style: ThemeText.subtitle2.copyWith(fontWeight: FontWeight.bold),),
                        trailing: IconButton(icon: const Icon(Icons.copy), onPressed: () {},)
                      ),
                    ]),
                  )
                ),
                const VSpace(),
        
                /// BANK ACCOUNT DETAIL
                Text('Please complete your bank account detail!', style: ThemeText.subtitle2.copyWith(fontWeight: FontWeight.bold)),
                const VSpaceShort(),
                const BankAccForm(),
                SizedBox(height: spacingUnit(2)),
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