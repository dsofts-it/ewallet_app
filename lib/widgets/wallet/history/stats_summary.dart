import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:get/route_manager.dart';

class StatsSummary extends StatelessWidget {
  const StatsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: _statsItem(context, 20, 'Income', true)),
      SizedBox(width: spacingUnit(1)),
      Expanded(child: _statsItem(context, 100, 'Outcome', false)),
    ]);
  }

  Widget _statsItem(BuildContext context, double number, String title, bool income) {
    double size = 24;
    double bgIcon = 0.5;
    double bg = 0.25;

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppLink.report);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: 4),
        decoration: BoxDecoration(
          color: income ? Colors.green.withValues(alpha: bg) : Colors.red.withValues(alpha: bg),
          borderRadius: ThemeRadius.medium
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: income ? Colors.green.withValues(alpha: bgIcon) : Colors.red.withValues(alpha: bgIcon),
              child: income ? Image.asset(ImgApi.iconGrdIncome, width: size) : Image.asset(ImgApi.iconGrdExpense, width: size),
            ),
            SizedBox(width: spacingUnit(1)),
            Column(children: [
              Text(title, style: ThemeText.paragraphBold),
              Text(
                '${income ? '+' : '-'}${userAccount.currencySymbol}$number',
                style: ThemeText.subtitle.copyWith(color: income ? Colors.green : Colors.red)
              ),
            ]),
          ],
        ),
      ),
    );
  }
}