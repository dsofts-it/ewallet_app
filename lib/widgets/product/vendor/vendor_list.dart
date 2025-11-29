import 'package:flutter/material.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/cards/vendor_landscape_card.dart';
import 'package:get/route_manager.dart';

class VendorList extends StatelessWidget {
  const VendorList({super.key, required this.items, this.purchaseRoute});

  final List<Vendor> items;
  final String? purchaseRoute;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
        left: spacingUnit(2),
        right: spacingUnit(2),
        bottom: spacingUnit(4),
        top: spacingUnit(2)
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        Vendor item = items[index]; 
        return Padding(
          padding: EdgeInsets.only(bottom: spacingUnit(1)),
          child: VendorLandscapeCard(
            logo: item.logo,
            name: item.name,
            hasPromo: item.hasPromo,
            onTap: purchaseRoute != null ? () {
              Get.toNamed(purchaseRoute!, arguments: {'vendorId': item.id});
            } : () {},
          ),
        );
      },
    );
  }
}