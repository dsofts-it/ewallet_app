import 'package:change_case/change_case.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ComparePieChart extends StatefulWidget {
  const ComparePieChart({super.key});

  @override
  State<ComparePieChart> createState() => _ComparePieChartState();
}

class _ComparePieChartState extends State<ComparePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PaperCard(
      flat: true,
      content: Column(children: [
        VSpaceShort(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.pie_chart, size: 24,),
          SizedBox(width: 4),
          Text('Expense and Income Percentage', style: ThemeText.subtitle2,),
        ]),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Compare your expenses and income', style: ThemeText.caption, textAlign: TextAlign.center),
        ),
        AspectRatio(
          aspectRatio: 1.3,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _indicator(context, ThemePalette.secondaryMain, false, 'Expense'),
                  _indicator(context, ThemePalette.primaryMain, false, 'Income'),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 0,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ])
    );
  }

  Widget _indicator(BuildContext context, Color color, bool isSquare, String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(text.toCapitalCase(), style: TextStyle(fontSize: 16,))
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;

      return switch (i) {
        0 => PieChartSectionData(
            color: ThemePalette.secondaryMain,
            value: 75,
            title: '',
            radius: 80,
            titlePositionPercentageOffset: 0.55,
            borderSide: isTouched
              ? const BorderSide(color: Colors.grey, width: 6)
              : BorderSide(color: Colors.grey.withValues(alpha: 0)),
          ),
        1 => PieChartSectionData(
            color: ThemePalette.primaryMain,
            value: 25,
            title: '',
            radius: 80,
            titlePositionPercentageOffset: 0.55,
            borderSide: isTouched
              ? const BorderSide(color: Colors.grey, width: 6)
              : BorderSide(color: Colors.grey.withValues(alpha: 0)),
          ),
        _ => throw StateError('Invalid'),
      };
    });
  }
}