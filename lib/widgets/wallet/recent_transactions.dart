import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/transfer_history.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/cards/transaction_card.dart';
import 'package:ewallet_app/widgets/title/title_action.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
        child: TitleAction(
          title: 'Recent Transaction',
          textAction: 'View All',
          onTap: () {
            Get.toNamed(AppLink.walletHistory);
          },
        ),
      ),
      SizedBox(height: spacingUnit(1)),
      ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 5,
        physics: const ClampingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: spacingUnit(1),),
        itemBuilder: (BuildContext context, int index) {
          Transfer item = transferList[index];
          
          return TransactionCard(
            userId: item.id,
            productName: '${setType(item.type)} ${item.subject.name}',
            groupName: item.category ?? getGroupName(item.type),
            transactionDate: item.transactionDate,
            status: item.status,
            price: item.price,
            isIncome: item.type == TransferType.receive,
            mini: true,
            onTap: () {
              Get.toNamed(AppLink.transferDetail);
            }
          );
        }
      )
    ]);
  }
}