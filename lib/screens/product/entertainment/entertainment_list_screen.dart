import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/purchase_history.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/product_layout.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/product/package/package_list_slider.dart';
import 'package:ewallet_app/widgets/product/vendor/vendor_grid.dart';
import 'package:ewallet_app/widgets/profile/latest_transactions.dart';
import 'package:flutter/material.dart';

class EntertainmentListScreen extends StatelessWidget {
  const EntertainmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Purchase> entertainTransaction = purchaseList.where(
      (item) => item.category == categoryList[8]
    ).toList();
    
    return ProductLayout(
      title: 'Streaming',
      headline: 'Nonstop Entertainment',
      searchTitle: 'Search streamings and entertainments',
      desc: 'Subscribe to music and video streaming with secure payments.',
      icon: ImgApi.icon3dEntertainment,
      background: ImgApi.entertainmentBg,
      color: getCategory('entertainment').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(vendorList: entertainmentVendors, purchaseRoute: AppLink.entertainmentPurchase),
        VSpaceBig(),

        /// LATEST TRANSACTION
        LatestTransactions(
          items: entertainTransaction,
          counts: entertainTransaction.length,
        ),
        VSpaceBig(),

        /// RECOMMENDED PACKAGE
        PackageListSlider(
          title: 'Recomended Streaming Plans',
          packageList: entertainmentPackages,
          withCover: false,
        ),
        VSpaceBig()
      ]
    );
  }
}