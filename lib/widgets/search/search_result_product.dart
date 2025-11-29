import 'package:change_case/change_case.dart';
import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/package_landscape_card.dart';
import 'package:ewallet_app/widgets/cards/product_portrait_card.dart';
import 'package:ewallet_app/widgets/product/detail/product_detail.dart';
import 'package:ewallet_app/widgets/product/detail/vendor_detail.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultProduct extends StatelessWidget {
  const SearchResultProduct({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    final List<Credit> allCredit = [
      ...appCredits,
      ...electricCredits,
      ...gameCredits,
      ...entertainmentCredits,
      ...educationCredits,
      ...mobileCredits
    ];

    final List<Package> allPackages = [
      ...appPackages,
      ...educationPackages,
      ...entertainmentPackages,
      ...gamePackages,
      ...mobilePackages,
    ];
  
    return ListView(children: [
      VSpace(),
      /// VENDOR RESULTS
      SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: vendorList.length,
          itemBuilder: (BuildContext context, int index) {
            final Vendor item = vendorList[index];
            final String vendorName = '${item.name} ${item.category ?? ''}';
            if (vendorName.toLowerCase().contains(keyword.toLowerCase())) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
                width: 80,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showVendorDetail(context);
                      },
                      child: AvatarNetwork(
                        radius: 20,
                        backgroundColor: colorScheme(context).surfaceDim,
                        backgroundImage: item.logo,
                        type: 'vendor',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: ThemeText.caption,)
                  ],
                ),
              );
            }
            
            return const SizedBox.shrink();
          },
        ),
      ),
      VSpace(),
    
      /// CREDIT RESULTS
      Padding(padding: EdgeInsetsGeometry.symmetric(
        horizontal: spacingUnit(2)),
        child: TitleBasic(title: 'Credit Voucher'),
      ),
      VSpaceShort(),
      SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: allCredit.length,
          itemBuilder: (BuildContext context, int index) {
            final Credit item = allCredit[index];
            final String creditName = '${item.unit} ${item.category} ${item.vendor?.name ?? ''}';
            if (creditName.toLowerCase().contains(keyword.toLowerCase())) {
              return Container(
                width: 190,
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
                child: InkWell(
                  onTap: () {
                    showProductDetail(context, item: item, withActionBtn: true);
                  },
                  child: ProductPortraitCard(
                    title: '${item.amount.toStringAsFixed(0)} ${item.unit.toCapitalCase()}',
                    thumb: item.thumb,
                    category: item.category,
                    type: item.type,
                    price: item.price,
                    additionalWidget: item.description != null ? Text(item.description!, style: ThemeText.caption,) : null,
                    discount: item.discount,
                    hasPromo: item.isPromo,
                    label: item.isPromo ? 'Promo' : null,
                    points: item.points,
                    mini: true,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      VSpace(),
    
      /// PACKAGE RESULTS;
      Padding(padding: EdgeInsetsGeometry.symmetric(
        horizontal: spacingUnit(2)),
        child: TitleBasic(title: 'Package Topups'),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(spacingUnit(2)),
        itemCount: allPackages.length,
        itemBuilder: (BuildContext context, int index) {
          final Package item = allPackages[index];
          final String packageName = '${item.name} ${item.category} ${item.vendor?.name ?? ''}';
          if (packageName.toLowerCase().contains(keyword.toLowerCase())) {
            return Padding(
              padding: EdgeInsets.only(bottom: spacingUnit(2)),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppLink.packageDetail);
                },
                child: PackageLandscapeCard(
                  image: item.thumb,
                  name: item.name,
                  price: item.price,
                  discount: item.discount,
                  feature1: item.features!.isNotEmpty ? item.features![0] : null,
                  feature2: item.features!.length > 1 ? item.features![1] : null,
                  points: item.points,
                  vendor: item.vendor,
                  label: item.discount > 0 ? 'Promo' : null,
                ),
              ),
            );
          }
    
          return const SizedBox.shrink();
        }
      )
    ]);
  }
}