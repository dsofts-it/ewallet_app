import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/controller/product_filter_controller.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFilter extends StatelessWidget {
  ProductFilter({super.key, required this.vendorList});

  final List<Vendor> vendorList;

  final ProductFilterController controller = Get.put(ProductFilterController());

  @override
  Widget build(BuildContext context) {
    List<String> sortList = ['amount', 'price', 'discount', 'provider'];
    return ListView(shrinkWrap: true, children: [

      /// SORTER
      Row(
        children: [
          Icon(Icons.sort),
          Text(' Sort by:', style: ThemeText.subtitle2),
        ],
      ),
      SizedBox(height: spacingUnit(1)),
      Obx(() => RadioGroup<String>(
        groupValue: controller.sortby.value,
        onChanged: (String? value) {
          controller.onUpdateSortBy(value);
        },
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: sortList.length,
          itemBuilder: (context, index) {
            final item = sortList[index];
            return RadioListTile<String>(
              title: Text(item[0].toUpperCase() + item.substring(1)),
              value: item,
            );
          },
        ),
      )),
      VSpace(),

      /// FILTER
      /// PRICE RANGE
      Row(
        children: [
          const Icon(Icons.price_change_outlined),
          Text(' Range Price:', style: ThemeText.subtitle2),
          SizedBox(width: spacingUnit(1)),
          Obx(() => Text(
            '${userAccount.currencySymbol}${controller.price.value.start.round()} - ${userAccount.currencySymbol}${controller.price.value.end.round()}',
            style: ThemeText.subtitle2.copyWith(color: colorScheme(context).onSecondaryContainer)
          )),
        ],
      ),
      SizedBox(height: spacingUnit(1)),
      Obx(() => RangeSlider(
        values: controller.price.value,
        max: 100,
        divisions: 5,
        labels: RangeLabels(
          controller.price.value.start.round().toString(),
          controller.price.value.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          controller.onChangePrice(values);
        },
      )),
      const VSpace(),

      /// DISCOUNT
      Row(
        children: [
          Icon(Icons.discount),
          Text(' Discount:', style: ThemeText.subtitle2),
        ],
      ),
      SizedBox(height: spacingUnit(1)),
      Obx(() => Wrap(
        spacing: spacingUnit(1),
        children: [
          _tagButton(
            context,
            'Has Promo',
            () { controller.onUpdatePromo('ispromo'); },
            controller.promos.contains('ispromo')
          ),
          _tagButton(
            context,
            'Discount > 9%',
            () { controller.onUpdatePromo('9%'); },
            controller.promos.contains('9%')
          ),
          _tagButton(
            context,
            'Discount > 20%',
            () { controller.onUpdatePromo('20%'); },
            controller.promos.contains('20%')
          ),
        ],
      )),
      const VSpace(),

      /// VENDORS
      Row(
        children: [
          Icon(Icons.layers),
          Text(' Vendors', style: ThemeText.subtitle2),
        ],
      ),
      SizedBox(height: spacingUnit(1)),
      ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: vendorList.length,
        itemBuilder: (context, index) {
          final Vendor item = vendorList[index];
      
          return Obx(() => CheckboxListTile(
            secondary: AvatarNetwork(
              radius: 15,
              backgroundImage: item.logo,
              type: 'vendor',
            ),
            title: Text(item.name),
            value: controller.vendors.contains(item.id),
            onChanged: (bool? value) {
              if (value == true) {
                controller.onUpdateVendor('add', item.id);
              } else {
                controller.onUpdateVendor('remove', item.id);
              }
            },
          ));
        },
      ),
    ]);
  }

  Widget _tagButton(BuildContext context, String text, Function() onTap, bool isSelected) {
    return ClipRRect(
      borderRadius: ThemeRadius.small,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme(context).primaryContainer : null,
            borderRadius: ThemeRadius.small,
            border: Border.all(
              width: 1,
              color: colorScheme(context).outlineVariant
            )
          ),
          child: Text(text, style: ThemeText.paragraph),
        ),
      ),
    );
  }
}


Future<void> showProductFilter(BuildContext context, Function() updateFilter, List<Vendor> vendors) {
  return Get.bottomSheet(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsetsGeometry.all(spacingUnit(2)),
        child: Column(children: [
          const GrabberIcon(),
          const VSpaceShort(),
          const TitleBasic(title: 'Filters', align: CrossAxisAlignment.center,),
          const VSpaceShort(),
          Expanded(
            child: ProductFilter(
              vendorList: vendors,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spacingUnit(1)),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  updateFilter();
                  Get.back();
                },
                style: ThemeButton.btnBig.merge(ThemeButton.tonalPrimary(context)),
                child: Text('Update Result'.toUpperCase(), style: ThemeText.subtitle2)
              ),
            )
          ),
          const VSpace()
        ]),
      );
    }),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: colorScheme(context).surface,
  );
}
