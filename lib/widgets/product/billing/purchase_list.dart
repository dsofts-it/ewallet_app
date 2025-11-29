import 'package:ewallet_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/decorations/dashed_border.dart';
import 'package:ewallet_app/widgets/payment/payment_item.dart';
import 'package:get/route_manager.dart';

class PurchaseList extends StatelessWidget {
  const PurchaseList({super.key, this.icon, required this.title});

  final Widget? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: spacingUnit(2)),
      physics: const ClampingScrollPhysics(),
      children: [
        Column(children: [
          icon ?? CircleAvatar(
            radius: 20,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: ThemePalette.primaryLight,
              child: Icon(Icons.payment, color: ThemePalette.primaryMain),
            ),
          ),
          SizedBox(height: spacingUnit(1)),
          Text(title, style: ThemeText.paragraphBold),
        ]),
        VSpace(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(3)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('22 Jun 2026', style: ThemeText.caption),
            Text('No.A1234567890SSR', style: ThemeText.caption),
          ]),
        ),
        SizedBox(height: spacingUnit(2)),
        PaymentItem(title: 'Account ID', boldValue: true, value: '08812345678'),
        PaymentItem(title: 'Name', boldValue: true, value: 'John Doe'),
        Padding(
          padding: EdgeInsets.all(spacingUnit(1)),
          child: DashedBorder(color: colorScheme(context).outlineVariant,),
        ),
        PaymentItem(title: 'Subtotal', boldValue: true, value: '${userAccount.currencySymbol}100'),
        PaymentItem(title: 'Admin Fee', boldValue: true, value: '${userAccount.currencySymbol}2'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
          decoration: BoxDecoration(
            borderRadius: ThemeRadius.medium,
            color: isDark ? colorScheme(context).secondaryContainer : colorScheme(context).primaryContainer
          ),
          child: ListTile(
            minTileHeight: 0,
            contentPadding: EdgeInsets.only(
              left: spacingUnit(2),
              right: spacingUnit(2),
              bottom: 0,
              top: 0,
            ),
            title: Text('Total', style: ThemeText.paragraphBold,),
            trailing: Text('${userAccount.currencySymbol}102', style: ThemeText.paragraphBold.copyWith(color: colorScheme(context).onSurface),),
          )
        )
      ]
    );
  }
}