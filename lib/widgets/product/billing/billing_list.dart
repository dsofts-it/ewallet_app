import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/billing.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/cards/billing_card.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BillingList extends StatelessWidget {
  const BillingList({super.key, required this.items, required this.counts, required this.title, this.subtitle});

  final List<Billing> items;
  final int counts;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          child: TitleBasic(title: title, desc: subtitle)
        ),
        SizedBox(height: spacingUnit(1),),
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: counts,
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: spacingUnit(1));
          },
          itemBuilder: ((BuildContext context, int index) {
            Billing item = items[index];
            return SizedBox(width: double.infinity, child: GestureDetector(
              onTap: () {
                Get.toNamed(AppLink.payment);
              },
              child: BillingCard(
                name: item.name,
                icon: item.icon,
                thumb: item.thumb,
                period: item.period,
                dueDate: item.dueDate,
                price: item.price,
                status: item.status,
              ),
            ));
          }),
        ),
      ],
    );
  }
}