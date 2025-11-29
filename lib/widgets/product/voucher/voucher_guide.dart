import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/app_input/app_input_box.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';

class VoucherGuide extends StatelessWidget {
  const VoucherGuide({ super.key });

  @override
  Widget build(BuildContext context) {
    return PaperCard(
      content: Padding(
        padding: EdgeInsets.all(spacingUnit(2)),
        child: Row(
          children: [
            Expanded(
              child: AppInputBox(content: ListTile(
                contentPadding: const EdgeInsets.all(0),
                minTileHeight: 0,
                leading: Icon(Icons.info_outline, color: ThemePalette.secondaryMain),
                title: Text('Guide to redeem voucher', style: ThemeText.paragraphBold,),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  showModalBottomSheet<dynamic>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: colorScheme(context).surface,
                    builder: (BuildContext context) {
                      return Wrap(
                        children: [
                          _voucherGuideDetail(context)
                        ]
                      );
                    }
                  );
                },
              )),
            ),
          ],
        )
      )
    );
  }

  Widget _voucherGuideDetail(BuildContext context) {
    final List<String> helpGuideList = [
      'Open the app or website of the service provider.',
      'Select the product or service you want to purchase.',
      'Proceed to the payment section.',
      'Choose the option to pay with a voucher or promo code.',
      'Enter the voucher code provided in your purchase confirmation.',
      'Apply the code and verify that the discount has been applied to your total amount.',
      'Complete the payment process to finalize your purchase.'
    ];

    return Column(children: [
      const GrabberIcon(),
      const VSpaceShort(),
      Text('Redeem Voucher Guide', textAlign: TextAlign.center, style: ThemeText.subtitle),
      const VSpaceShort(),
      ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(spacingUnit(2)),
        itemCount: helpGuideList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: spacingUnit(3)),
                margin: const EdgeInsets.only(left: 9),
                decoration: BoxDecoration(
                  border: index < helpGuideList.length - 1 ? Border(left: BorderSide(color: colorScheme(context).primaryContainer, width: 1)) : null
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: spacingUnit(2)),
                  child: Text(helpGuideList[index], textAlign: TextAlign.start, style: ThemeText.paragraph),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: colorScheme(context).primaryContainer,
                  child: Text('${index + 1}', style: ThemeText.caption.copyWith(color: colorScheme(context).onPrimaryContainer))
                ),
              ),
            ],
          );
        }
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ThemeButton.btnBig.merge(ThemeButton.outlinedPrimary(context)),
          child: const Text('UNDERSTAND')
        ),
      ),
      const VSpaceBig()
    ]);
  }
}
