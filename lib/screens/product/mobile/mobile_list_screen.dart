import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/product_layout.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/product/package/package_list_slider.dart';
import 'package:ewallet_app/widgets/product/topup/topup_list_slider.dart';
import 'package:ewallet_app/widgets/product/vendor/vendor_grid.dart';
import 'package:flutter/material.dart';

class MobileListScreen extends StatelessWidget {
  const MobileListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Package> packageList = [
      mobilePackages[0],
      mobilePackages[4],
      mobilePackages[7],
      mobilePackages[11],
      mobilePackages[14],
      mobilePackages[18],
      mobilePackages[3],
      mobilePackages[17],
      mobilePackages[1],
      mobilePackages[6],
    ];

    return ProductLayout(
      title: 'Mobile',
      headline: 'Stay Connected',
      searchTitle: 'Search mobile package and credit',
      desc: 'Top up your data and packages instantly, anywhere you go.',
      icon: ImgApi.icon3dMobile,
      background: ImgApi.mobileBg,
      color: getCategory('mobile').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(vendorList: mobileVendors, purchaseRoute: AppLink.mobilePurchase),
        VSpaceBig(),

        /// RECOMMENDED PACKAGE
        PackageListSlider(
          title: 'Recomended Mobile Package',
          packageList: packageList,
          withCover: false,
        ),
        VSpace(),
        TopupListSlider(
          title: 'Recomended Mobile Vouchers',
          creditList: mobileCredits.sublist(0, 5),
          category: 'mobile',
          creditType: CreditType.money,
        ),
        VSpaceBig()
      ]
    );
  }
}