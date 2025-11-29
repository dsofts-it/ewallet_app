import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/cards/vendor_portrait_card.dart';
import 'package:ewallet_app/widgets/product/vendor/vendor_list.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class VendorGrid extends StatelessWidget {
  const VendorGrid({
    super.key,
    required this.vendorList,
    required this.purchaseRoute,
    this.maxLength = 8
  });

  final List<Vendor> vendorList;
  final String purchaseRoute;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final bool wideScreen = ThemeBreakpoints.smUp(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          child: TitleBasic(title: 'Choose a Service')
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(spacingUnit(2)),
          physics: const ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 120,
            maxCrossAxisExtent: wideScreen ? 200 : 100,
            crossAxisSpacing: spacingUnit(1),
            mainAxisSpacing: spacingUnit(2),
            childAspectRatio: 2
          ),
          itemCount: vendorList.length > maxLength ? maxLength : vendorList.length,
          itemBuilder: (context, index) {
            Vendor item = vendorList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(purchaseRoute, arguments: {'vendorId': item.id});
              },
              child: VendorPortraitCard(
                logo: item.logo,
                name: item.name,
                hasPromo: item.hasPromo,
              )
            );
          },
        ),
        vendorList.length > maxLength ? Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          child: OutlinedButton(
            onPressed: () {
              Get.bottomSheet(
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(children: [
                    VSpaceShort(),
                    GrabberIcon(),
                    VSpaceShort(),
                    Expanded(child: VendorList(items: vendorList, purchaseRoute: purchaseRoute,))
                  ])
                ),
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                backgroundColor: colorScheme(context).surface,
              );
            },
            style: ThemeButton.btnMedium.merge(ThemeButton.outlinedInvert(context)),
            child: Text('View All', style: ThemeText.paragraph,)
          ),
        ) : Container()
      ],
    );
  }
}