import 'package:change_case/change_case.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/cards/package_landscape_card.dart';
import 'package:ewallet_app/widgets/cards/product_landscape_card.dart';
import 'package:ewallet_app/widgets/cards/product_portrait_card.dart';
import 'package:ewallet_app/widgets/product/detail/package_detail.dart';
import 'package:ewallet_app/widgets/product/detail/product_detail.dart';
import 'package:ewallet_app/widgets/title/title_action.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class VoucherGridList extends StatelessWidget {
  const VoucherGridList({super.key, required this.creditItems, required this.packageItems});

  final List<Credit> creditItems;
  final List<Package> packageItems;

  @override
  Widget build(BuildContext context) {
    final bool wideScreen = ThemeBreakpoints.xsUp(context);

    void showAllCredits() async {
      Get.bottomSheet(
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.all(spacingUnit(2)),
          child: Column(children: [
            VSpaceShort(),
            GrabberIcon(),
            VSpaceShort(),
            Expanded(child: _allCreditList(context))
          ])
        ),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: colorScheme(context).surface,
      );
    }

    return ListView(padding: EdgeInsets.zero, shrinkWrap: true, children: [
      /// CREDIT VOUCHERS
      VSpace(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        child: TitleAction(
          title: 'Credit Vouchers',
          textAction: 'View All',
          onTap:() {
            showAllCredits();
          },
        ),
      ),
      GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(spacingUnit(2)),
        itemCount: creditItems.length > 6 ? 6 : creditItems.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemProductBuilder(context, creditItems[index]);
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: wideScreen ? 300 : 200,
          mainAxisExtent: 200,
          childAspectRatio: 0.8,
          crossAxisSpacing: spacingUnit(1),
          mainAxisSpacing: spacingUnit(2),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                showAllCredits();
              },
              style: ThemeButton.btnMedium.merge(ThemeButton.outlinedInvert(context)),
              child: Text('View All', style: ThemeText.paragraph,)
            ),
          ],
        ),
      ),
      VSpaceBig(),

      /// PACKAGE VOUCHERS
      Padding(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        child: TitleBasic(title: 'Package Vouchers'),
      ),
      ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: spacingUnit(2)),
        padding: EdgeInsets.all(spacingUnit(2)),
        itemCount: packageItems.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemPackageBuilder(context, packageItems[index]);
        }
      )

    ]);
  }

  Widget _itemProductBuilder(BuildContext context, Credit item) {
    return GestureDetector(
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
    );
  }

  Widget _itemPackageBuilder(BuildContext context, Package item) {
    return GestureDetector(
      onTap: () {
        showPackageDetail(context, item: item, withActionBtn: true);
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
    );
  }

  Widget _allCreditList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: spacingUnit(2)),
      padding: EdgeInsets.only(
        top: spacingUnit(2),
        left: spacingUnit(1),
        right: spacingUnit(1),
        bottom: spacingUnit(3)
      ),
      itemCount: creditItems.length,
      itemBuilder: (BuildContext context, int index) {
        final Credit item = creditItems[index];

        return GestureDetector(
          onTap: () {},
          child: ProductLandscapeCard(
            title: '${item.amount.toStringAsFixed(0)} ${item.unit}',
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
        );
      }
    );
  }
}