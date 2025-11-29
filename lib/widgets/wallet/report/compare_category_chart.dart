import 'package:change_case/change_case.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<CategoryType> categories = [
  categoryList[32],
  categoryList[36],
  categoryList[7],
  categoryList[40],
  categoryList[46],
];

class CompareCategoryChart extends StatefulWidget {
  const CompareCategoryChart({super.key});

  @override
  State<CompareCategoryChart> createState() => _CompareCategoryChartState();
}

class _CompareCategoryChartState extends State<CompareCategoryChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PaperCard(
      flat: true,
      content: Column(
        children: [
          VSpaceShort(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.grid_view_rounded, size: 24,),
            SizedBox(width: 4),
            Text('Expense by Categories', style: ThemeText.subtitle2,),
          ]),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('Compare your expenses by category', style: ThemeText.caption, textAlign: TextAlign.center),
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Row(
              children: <Widget>[
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
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categories.asMap().entries.map((entry) {
                    CategoryType item = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: _indicator(context, item.color, false, item.name),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ],
      ),
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
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: categories[0].color,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          );
        case 1:
          return PieChartSectionData(
            color: categories[1].color,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          );
        case 2:
          return PieChartSectionData(
            color: categories[2].color,
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          );
        case 3:
          return PieChartSectionData(
            color: categories[3].color,
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          );
        case 4:
          return PieChartSectionData(
            color: categories[4].color,
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          );
        default:
          throw Error();
      }
    });
  }
}