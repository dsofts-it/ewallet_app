import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';

class VoucherCode extends StatelessWidget {
  const VoucherCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: spacingUnit(3)),
      padding: EdgeInsets.all(spacingUnit(1)),
      decoration: BoxDecoration(
        borderRadius: ThemeRadius.medium,
        color: colorScheme(context).secondaryContainer,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Code Voucher', style: ThemeText.caption),
            Text('098765432112345', style: ThemeText.subtitle),
          ],
        ),
        SizedBox(width: spacingUnit(1)),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: colorScheme(context).onSurface ),
          child: Column(children: [
            Icon(Icons.copy),
            Text('Copy', style: ThemeText.caption),
          ]),
          onPressed: () {}
        )
      ])
    );
  }
}