import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseChartSmall extends StatelessWidget {
  const ExpenseChartSmall({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.red;
    BarChartGroupData generateGroupData(int x, int y) {
      return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: y.toDouble(),
            color: color,
            width: 10,
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }

    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              'Last 7 days',
              style: TextStyle(
                fontSize: 10,
                color: colorScheme(context).onSurface
              ),
            ),
          ),
        ),
        gridData: const FlGridData(
          show: false, // Hide grid lines
        ),
        borderData: FlBorderData(
          show: false, // Hide border
        ),
        barGroups: [
          generateGroupData(1, 10),
          generateGroupData(2, 8),
          generateGroupData(3, 4),
          generateGroupData(4, 4),
          generateGroupData(5, 2),
          generateGroupData(6, 6),
          generateGroupData(7, 1),
        ],
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipMargin: 0,
            tooltipPadding: const EdgeInsets.all(0),
            getTooltipColor: (touchedSpot) => Colors.transparent, 
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                rod.toY.round().toString(),
                TextStyle(
                  color: color,
                  fontSize: 11
                ),
              );
            },
          )
        ),
      ),
    );
  }
}