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

class EducationListScreen extends StatelessWidget {
  const EducationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Purchase> educationTransaction = purchaseList.where(
      (item) => item.category == categoryList[6]
    ).toList();

    return ProductLayout(
      title: 'Education',
      headline: 'Invest in Learning',
      searchTitle: 'Search streamings and entertainments',
      desc: 'Pay tuition, courses, and e-learning easily from your e-wallet.',
      icon: ImgApi.icon3Education,
      background: ImgApi.educationBg,
      color: getCategory('education').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(vendorList: educationVendors, purchaseRoute: AppLink.educationPurchase),
        VSpaceBig(),

        /// LATEST TRANSACTION
        LatestTransactions(
          items: educationTransaction,
          counts: educationTransaction.length,
        ),
        VSpaceBig(),

        /// RECOMMENDED PACKAGE
        PackageListSlider(
          title: 'Recomended Education Plans',
          packageList: educationPackages,
          withCover: false,
        ),
        VSpace(),
        TopupListSlider(
          title: 'Recomended Credit Topup',
          creditList: educationCredits,
          category: 'education',
          creditType: CreditType.coin,
        ),
        VSpaceBig()
      ]
    );
  }
}