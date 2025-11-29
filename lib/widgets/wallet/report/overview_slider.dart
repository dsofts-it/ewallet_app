import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/cards/stats_card.dart';
import 'package:ewallet_app/widgets/wallet/report/balance_stats.dart';
import 'package:ewallet_app/widgets/wallet/report/expense_chart_small.dart';
import 'package:ewallet_app/widgets/wallet/report/income_chart_small.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OverviewSlider extends StatelessWidget {
  const OverviewSlider({super.key});

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 330;
    double bg = Get.isDarkMode ? 0.35 : 0.15;
    
    return SizedBox(
      height: 150,
      child: ListView(
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: spacingUnit(2),
              right: spacingUnit(1),
            ),
            width: cardWidth,
            child: StatsCard(
              bigText: 'Medium',
              title: 'Expense/Balance(%)',
              background: ThemePalette.secondaryMain.withValues(alpha: bg),
              foreground: colorScheme(context).onSecondaryContainer,
              infoGraphic: BalanceStats()
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
            width: cardWidth,
            child: StatsCard(
              bigText: '${userAccount.currencySymbol}100',
              title: 'Total Expense',
              background: Colors.red.withValues(alpha: bg),
              foreground: Colors.red,
              infoGraphic: SizedBox(
                width: 160,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: ExpenseChartSmall(),
                ),
              )
            )
          ),
          Container(
            padding: EdgeInsets.only(
              left: spacingUnit(1),
              right: spacingUnit(2),
            ),
            width: cardWidth,
            child: StatsCard(
              bigText: '${userAccount.currencySymbol}20',
              title: 'Total Income',
              background: Colors.green.withValues(alpha: bg),
              foreground: Colors.green,
              infoGraphic: SizedBox(
                width: 160,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: IncomeChartSmall(),
                ),
              )
            )
          )
        ]
      ),
    );
  }
}