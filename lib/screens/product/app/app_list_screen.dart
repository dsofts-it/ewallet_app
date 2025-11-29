import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/purchase_history.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/product_layout.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/product/package/package_list_slider.dart';
import 'package:ewallet_app/widgets/product/topup/topup_list_slider.dart';
import 'package:ewallet_app/widgets/product/vendor/vendor_grid.dart';
import 'package:ewallet_app/widgets/profile/latest_transactions.dart';
import 'package:flutter/material.dart';

class AppListScreen extends StatelessWidget {
  const AppListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Purchase> appTransaction = purchaseList.where(
      (item) => item.category == categoryList[0]
    ).toList();

    return ProductLayout(
      title: 'Apps',
      headline: 'Unlock Premium Apps',
      searchTitle: 'Search apps and platforms',
      desc: 'Subscribe and pay for your favorite apps seamlessly.',
      icon: ImgApi.icon3dApps,
      background: ImgApi.appsBg,
      color: getCategory('apps').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(vendorList: appVendors, purchaseRoute: AppLink.appPurchase),
        VSpaceBig(),

        /// LATEST TRANSACTION
        LatestTransactions(
          items: appTransaction,
          counts: appTransaction.length,
        ),
        VSpaceBig(),

        /// RECOMMENDED PACKAGE
        PackageListSlider(
          title: 'Recomended Apps Package',
          packageList: appPackages,
          withCover: false,
        ),
        VSpace(),
        TopupListSlider(
          title: 'Recomended App Credit Topup',
          creditList: appCredits,
          category: 'apps',
          creditType: CreditType.diamond,
        ),
        VSpaceBig()
      ]
    );
  }
}