import 'package:ewallet_app/controller/history_filter_controller.dart';
import 'package:ewallet_app/models/purchase_history.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/widgets/wallet/history/purchase_history_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/datepicker_range.dart';
import 'package:ewallet_app/widgets/filters/filter_list.dart';
import 'package:ewallet_app/widgets/header/header_filter.dart';
import 'package:ewallet_app/widgets/wallet/history/stats_summary.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> with RestorationMixin {
  final HistoryFilterController _historyCtrl = Get.put(HistoryFilterController());
  final TextEditingController _textRef = TextEditingController(text: '');
  final List<String> tagFilter = ['This week', 'This month', 'Last month', '>2 Months', '>3 Months'];
  int _active = 0;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime(2025, 3, 1));
  final RestorableDateTimeN _endDate = RestorableDateTimeN(DateTime(2025, 3, 5));

  List<Purchase> _filteredHistory = purchaseList;

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
      });
    }
  }

  void _onFilterHistory() async {
    _historyCtrl.onFilterHistory();
    await Future.delayed(Duration(milliseconds: 500));
    List<Purchase> convertedList = _historyCtrl.filteredHistory.cast<Purchase>();

    setState(() {
      _filteredHistory = convertedList;
    });
  }

  void _onSearchHistory(String val) async {
    _historyCtrl.onSearch(val);
    await Future.delayed(Duration(milliseconds: 500));
    List<Purchase> convertedList = _historyCtrl.filteredHistory.cast<Purchase>();

    setState(() {
      _filteredHistory = convertedList;
    });
  }

  @override
  void initState() {
    super.initState(); // Always call super.initState() first
    _historyCtrl.loadItems(purchaseList);
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: HeaderFilter(
          selectedTitle: HistoryType.purchased,
          title: 'Purchased',
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
      body: Column(children: [
        /// STATS
        Padding(
          padding: EdgeInsets.all(spacingUnit(2)),
          child: StatsSummary(),
        ),
        
        /// TAG FILTER
        FilterList(
          withFilter: true,
          withSearch: true,
          items: tagFilter,
          textCtrl: _textRef,
          onSubmitSearch: (String val) {
            _onSearchHistory(val);
          },
          onFiltered: () {
            _onFilterHistory();
          },
          onSelected: (int val) {
            setState(() {
              _active = val;
            });
          },
          selected: tagFilter[_active],
        ),
        VSpaceShort(),

        /// ITEMS
        Expanded(
          child: PurchaseHistoryList(items: _filteredHistory)
        )
      ]),
    );
  }
}