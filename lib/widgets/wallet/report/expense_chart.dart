import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: [],
      barRods: [
        BarChartRodData(
          color: ThemePalette.secondaryMain,
          toY: y.toDouble()
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      meta: meta,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool wideScreen = ThemeBreakpoints.smUp(context);

    return PaperCard(
      flat: true,
      content: Column(
        children: [
          VSpaceShort(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.file_upload_outlined, size: 24,),
            SizedBox(width: 4),
            Text('Expenses', style: ThemeText.subtitle2,),
          ]),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('The total amount(${userAccount.currencySymbol}) of your expenses in a week', style: ThemeText.caption, textAlign: TextAlign.center),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(spacingUnit(2)),
              child: AspectRatio(
                aspectRatio: wideScreen ? 3 : 2,
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: bottomTitles,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      border: Border(
                        bottom: BorderSide(color: colorScheme.outline),
                        left: BorderSide(color: colorScheme.outline),
                      )
                    ),
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: colorScheme.outlineVariant,
                        strokeWidth: 1,
                        dashArray: [5, 6]
                      ),
                      drawVerticalLine: false,
                    ),
                    barGroups: [
                      generateGroupData(0, 10),
                      generateGroupData(1, 3),
                      generateGroupData(2, 18),
                      generateGroupData(3, 4),
                      generateGroupData(4, 11),
                      generateGroupData(5, 18),
                      generateGroupData(6, 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}