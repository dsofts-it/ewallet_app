import 'package:ewallet_app/models/category_report.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/datepicker_range.dart';
import 'package:ewallet_app/widgets/filters/filter_list.dart';
import 'package:ewallet_app/widgets/header/header_filter.dart';
import 'package:ewallet_app/widgets/tab_menu/tab_menu_basic.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:ewallet_app/widgets/wallet/report/category_report_list.dart';
import 'package:ewallet_app/widgets/wallet/report/compare_bar_chart.dart';
import 'package:ewallet_app/widgets/wallet/report/compare_category_chart.dart';
import 'package:ewallet_app/widgets/wallet/report/compare_pie_chart.dart';
import 'package:ewallet_app/widgets/wallet/report/expense_chart.dart';
import 'package:ewallet_app/widgets/wallet/report/income_chart.dart';
import 'package:ewallet_app/widgets/wallet/report/overview_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with RestorationMixin {
  final List<String> tagFilter = ['This week', 'This month', 'Last month', '>2 Months', '>3 Months'];
  int _active = 0;
  int _currentTab = 0;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime(2025, 3, 1));
  final RestorableDateTimeN _endDate = RestorableDateTimeN(DateTime(2025, 3, 5));

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
      });
    }
  }

  @override
  String? get restorationId => 'my_restorable_datetime_widget';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'selected_start_date_time');
    registerForRestoration(_endDate, 'selected_start_date_time');
  }

  @override
  Widget build(BuildContext context) {
    DateTime? convertedStart = _startDate.value?.toLocal();
    DateTime? convertedEnd = _endDate.value?.toLocal();
    final bool wideScreen = ThemeBreakpoints.smUp(context);
    final bool longScreen = ThemeBreakpoints.mdUp(context);

    final List<Widget> tabContent = <Widget>[
      /// EXPENSE DETAIL
      ListView(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ExpenseChart(),
          VSpace(),
          TitleBasic(title: 'Expense by Category'),
          VSpaceShort(),
          CategoryReportList(items: expenseByCategoryList),
          VSpaceBig(),
        ],
      ),

      /// INCOME DETAIL
      ListView(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          IncomeChart(),
          VSpace(),
          TitleBasic(title: 'Income by Category'),
          VSpaceShort(),
          CategoryReportList(items: incomeByCategoryList),
          VSpaceBig(),
        ],
      ),

      /// COMPARE DETAIL
      ListView(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          CompareBarChart(),
          VSpace(),

          /// CHART FOR MOBILE SCREEN
          !wideScreen ? CompareCategoryChart() : Container(),
          !wideScreen ? VSpace() : Container(),
          !wideScreen ?  ComparePieChart() : Container(),

          /// CHART FOR TABLET SCREEN
          wideScreen ? Row(children: [
            Expanded(child: SizedBox(
              height: longScreen ? 450 : 350,
              child: CompareCategoryChart())
            ),
            SizedBox(width: spacingUnit(2),),
            Expanded(child: SizedBox(
              height: longScreen ? 450 : 350,
              child: ComparePieChart())
            ),
          ]) : Container(),
          VSpaceBig(),
        ],
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: HeaderFilter(
          title: 'Finance Stats',
          subtitle: '${DateFormat('d MMMM').format(convertedStart ?? DateTime.now())} - ${DateFormat('d MMMM').format(convertedEnd ?? DateTime.now())}',
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
              child: DatepickerRange(
                startDate: _startDate,
                endDate: _endDate,
                selectDateRange: _selectDateRange,
                calendarButton: Icon(
                  Icons.calendar_month_outlined,
                  size: 32,
                  color: colorScheme(context).onSurface,
                )
              ),
            )
          ],
        )
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          /// TAG FILTER
          SliverToBoxAdapter(
            child: FilterList(
              items: tagFilter,
              onFiltered: () {},
              onSelected: (int val) {
                setState(() {
                  _active = val;
                });
              },
              selected: tagFilter[_active],
            ),
          ),

          /// OVERVIEW SLIDER
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
              child: OverviewSlider(),
            )
          ),

          /// TAB MENU
          SliverStickyHeader.builder(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
                color: colorScheme(context).surfaceContainerLow,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: ThemeSize.xs
                    ),
                    child: TabMenuBasic(
                      menus: <String>['Expense', 'Income', 'Compare'],
                      current: _currentTab,
                      onSelect: (int index) {
                        setState(() {
                          _currentTab = index;
                        });
                      },
                    ),
                  ),
                ),
              );
            },
            sliver: SliverToBoxAdapter(child: tabContent[_currentTab],)
          )
          
        ],
      ),
    );
  }
}