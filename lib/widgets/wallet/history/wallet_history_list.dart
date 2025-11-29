import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/category_type.dart';
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

class WalletHistoryList extends StatelessWidget {
  const WalletHistoryList({super.key, required this.items});

  final List<Transfer> items;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;
    
    CategoryType getGroupName(TransferType type) {
      switch(type) {
        case TransferType.receive:
          return getCategory('income');
        case TransferType.withdraw:
          return getCategory('service');
        default:
          return getCategory('expense');
      }
    }
    
    String setType(TransferType type) {
      switch(type) {
        case TransferType.receive:
          return 'Receive from';
        case TransferType.withdraw:
          return 'Withdraw to';
        default:
          return 'Transfer to';
      }
    }

    return GroupedListView<Transfer, String>(
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
            userId: element.id,
            productName: '${setType(element.type)} ${element.subject.name}',
            groupName: element.category ?? getGroupName(element.type),
            transactionDate: element.transactionDate,
            status: element.status,
            price: element.price,
            isIncome: element.type == TransferType.receive,
            mini: true,
            onTap: () {
              Get.toNamed(AppLink.transferDetail);
            },
            onShowOpt: () {
              showOptTransaction(context);
            },
          )
        );
      },
    );
  }
}