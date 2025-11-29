import 'package:change_case/change_case.dart';
import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AutocompleteList extends StatelessWidget {
  const AutocompleteList({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(spacingUnit(1)),
      itemCount: vendorList.length,
      itemBuilder: (context, index) {
        final Vendor item = vendorList[index];
        final String vendor = '${item.name} ${item.category ?? ''}';
        if (!vendor.toLowerCase().contains(keyword.toLowerCase())) {
          return const SizedBox.shrink();
        }
        return ListTile(
          leading: AvatarNetwork(
            radius: 20,
            backgroundColor: colorScheme(context).surfaceDim,
            backgroundImage: item.logo
          ),
          title: Text(item.name.toCapitalCase()),
          subtitle: item.category != null ? Text(item.category!.toCapitalCase()) : null,
          onTap: () {
            Get.toNamed(AppLink.search);
          },
        );
      },
    );
  }
}