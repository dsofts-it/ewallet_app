import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:ewallet_app/models/topup_history.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/datepicker_range.dart';
import 'package:ewallet_app/widgets/cards/topup_wallet_card.dart';
import 'package:ewallet_app/widgets/header/header_filter.dart';

class TopupHistoryScreen extends StatefulWidget {
  const TopupHistoryScreen({super.key});

  @override
  State<TopupHistoryScreen> createState() => _TopupHistoryScreenState();
}

class _TopupHistoryScreenState extends State<TopupHistoryScreen> with RestorationMixin {
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

    TopupStatus setStatus(int status) {
      if (status == 1) {
        return TopupStatus(color: Colors.deepOrangeAccent, text: 'Waiting for Payment', icon: Icons.access_time);
      } else if (status == 2) {
        return TopupStatus(color: Colors.red, text: 'Failed', icon: Icons.remove_circle_outline);
      } else {
        return TopupStatus(color: Colors.green, text: 'Success', icon: Icons.file_upload_outlined);
      }
    }

    Future<void> showDetail(TopupHistory item) async {
      Get.bottomSheet(
        Wrap(children: [
          VSpaceShort(),
          GrabberIcon(),
          VSpaceShort(),
          Padding(
            padding: EdgeInsets.all(spacingUnit(2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${DateFormat.yMMMd().format(item.transactionDate)} • 5:34 AM', style: ThemeText.subtitle2),
                Chip(
                  label: Text(setStatus(item.status).text, style: ThemeText.paragraph.copyWith(color: setStatus(item.status).color)),
                  backgroundColor: setStatus(item.status).color.withValues(alpha: 0.25),
                  shape: RoundedRectangleBorder(borderRadius: ThemeRadius.big, side: BorderSide(
                    color: Colors.transparent
                  )),
                )
              ],
            ),
          ),
          VSpaceShort(),
          SizedBox(
            height: 500,
            child: BillingDetail(
              name: 'Bank ABC Virtual Account',
              withBtn: false,
              icon: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/logos/logo3.png', width: 40,),
              ),
            ),
          ),
        ]),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: colorScheme(context).surface,
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: HeaderFilter(
          selectedTitle: HistoryType.topup,
          title: 'Topup',
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
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(spacingUnit(2)),
            itemCount: topupHistoryList.length,
            itemBuilder: (context, index) {
              TopupHistory item = topupHistoryList[index];
              return TopupWalletCard(
                date: item.transactionDate,
                amount: item.amount,
                isLast: index >= topupHistoryList.length - 1,
                timeLeft: '02:59:55',
                status: item.status,
                onTapInfo: () {
                  showDetail(item);
                },
              );
            },
          ),
        )
      ]),
    );
  }
}