import 'package:change_case/change_case.dart';
import 'package:ewallet_app/models/account_id.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AccountList extends StatelessWidget {
  const AccountList({
    super.key,
    required this.items,
    required this.keyword,
    this.showAll = false,
    this.onSelect
  });
  
  final List<AccountId> items;
  final String keyword;
  final bool showAll;
  final Function(AccountId)? onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(spacingUnit(2)),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final AccountId item = items[index];
        final String account = '${item.userId} ${item.name}';
        if (!account.toLowerCase().contains(keyword.toLowerCase()) && !showAll) {
          return const SizedBox.shrink();
        }
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: getCategory(item.category).color.withValues(alpha: 0.5),
            child: Image.asset(getCategory(item.category).image, width: 32,),
          ),
          title: Text(item.userId, style: ThemeText.paragraph,),
          subtitle: Text(item.name ?? item.category.toCapitalCase(), style: ThemeText.caption),
          onTap: () {
            onSelect != null ? onSelect!(item) : Get.back();
          },
          trailing: item.isFavorited ? Icon(Icons.favorite, size: 18, color: Colors.pink) : null,
        );
      },
    );
  }
}