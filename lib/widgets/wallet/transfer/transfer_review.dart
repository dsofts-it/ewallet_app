import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/models/bank.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';

class TransferReview extends StatelessWidget {
  const TransferReview({super.key});

  @override
  Widget build(BuildContext context) {
    final Bank item = bankList[0];
    
    return Column(children: [
      Container(
        width: 360,
        decoration: BoxDecoration(
          borderRadius: ThemeRadius.medium,
          color: colorScheme(context).primaryContainer.withValues(alpha: 0.25)
        ),
        child: Padding(
          padding: EdgeInsets.all(spacingUnit(2)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image(image: AssetImage(item.logo), height: 50),
            SizedBox(width: spacingUnit(1)),
            Column(
              children: [
                Text(item.name, style: ThemeText.subtitle2),
                Text(item.number, style: ThemeText.paragraph),
              ],
            )
          ]),
        )
      ),
      VSpaceShort(),
      Padding(
        padding: EdgeInsets.all(spacingUnit(1)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total Transfer', style: ThemeText.paragraph),
          Text('${userAccount.currencySymbol}45', style: ThemeText.paragraphBold),
        ]),
      ),
      Padding(
        padding: EdgeInsets.all(spacingUnit(1)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Admin Fee', style: ThemeText.paragraph),
          Text('${userAccount.currencySymbol}1', style: ThemeText.paragraphBold),
        ]),
      ),
    ]);
  }
}