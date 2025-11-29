import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/purchase_history.dart';
import 'package:ewallet_app/models/transfer_history.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/transaction_card.dart';

class PurchaseHistoryList extends StatelessWidget {
  const PurchaseHistoryList({super.key, required this.items});

  final List<Purchase> items;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return GroupedListView<Purchase, String>(
      elements: items,
      padding: EdgeInsets.only(bottom: spacingUnit(3)),
      groupBy: (n) => DateFormat.yMMMd().format(n.transactionDate),
      physics: const AlwaysScrollableScrollPhysics(),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      floatingHeader: false,
      groupStickyHeaderBuilder: (dynamic value) => Container(
        color: colorScheme(context).surfaceContainerLow,
        padding: EdgeInsets.symmetric(vertical: spacingUnit(1), horizontal: spacingUnit(2),),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? ThemePalette.primaryDark : colorScheme(context).surfaceDim,
                borderRadius: ThemeRadius.big
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: 4),
                child: Text(
                  DateFormat.yMMMd().format(value.transactionDate),
                  textAlign: TextAlign.start,
                  style: ThemeText.paragraphBold
                ),
              ),
            ),
          ],
        )
      ),
      groupSeparatorBuilder: (String value) => Container(
        padding: EdgeInsets.symmetric(vertical: spacingUnit(1), horizontal: spacingUnit(2),),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? ThemePalette.primaryDark : colorScheme(context).surfaceDim,
                borderRadius: ThemeRadius.big
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: 4),
                child: Text(
                  value,
                  textAlign: TextAlign.start,
                  style: ThemeText.paragraphBold
                ),
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (c, element) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: spacingUnit(1)),
          child: TransactionCard(
            userId: element.userId,
            productName: element.productName,
            groupName: element.category,
            transactionDate: element.transactionDate,
            status: element.status,
            price: element.price,
            thumb: element.thumb,
            vendor: element.vendor,
            isIncome: element.type == TransferType.receive,
            onShowOpt: () {
              showOptTransaction(context);
            },
            onTap: () {
              Get.toNamed(AppLink.purchaseDetail);
            },
            onTapAction: () {
              Get.toNamed(AppLink.payment);
            },
          )
        );
      },
    );
  }
}