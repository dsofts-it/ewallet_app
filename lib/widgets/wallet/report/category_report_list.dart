import 'package:change_case/change_case.dart';
import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/models/category_report.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CategoryReportList extends StatelessWidget {
  const CategoryReportList({super.key, required this.items});

  final List<CategoryReport> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          onTap: () {
            Get.toNamed(AppLink.history);
          },
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: item.category.color.withValues(alpha: 0.25),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Image.asset(item.category.image, width: 32),
            ),
          ),
          title: Text(item.category.name.toCapitalCase(), style: ThemeText.subtitle2),
          subtitle: LinearProgressIndicator(
            borderRadius: ThemeRadius.big,
            value: item.percentage / 100,
            backgroundColor: item.category.color.withValues(alpha: 0.2),
            color: item.category.color,
            minHeight: 10,
            semanticsLabel: 'Percentage of amount in ${item.category.name}',
          ),
          trailing: Text('${userAccount.currencySymbol}${item.amount}', style: ThemeText.subtitle2),
        );
      },
    );
  }
}