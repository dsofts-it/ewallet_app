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

class GameListScreen extends StatelessWidget {
  const GameListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Package> packageList = [
      gamePackages[0],
      gamePackages[9],
      gamePackages[4],
      gamePackages[10],
      gamePackages[7],
      gamePackages[1],
      gamePackages[11],
      gamePackages[15],
      gamePackages[12],
      gamePackages[14],
    ];

    final List<Purchase> gameTransaction = purchaseList.where(
      (item) => item.category == categoryList[14]
    ).toList();
    
    return ProductLayout(
      title: 'Games',
      headline: 'Level Up Your Play',
      searchTitle: 'Search games, voucher or topups',
      desc: 'Buy game credits and vouchers with just one tap.',
      icon: ImgApi.icon3dGame,
      background: ImgApi.gameBg,
      color: getCategory('game').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(vendorList: gameVendors, purchaseRoute: AppLink.gamePurchase),
        VSpaceBig(),

        /// LATEST TRANSACTION
        LatestTransactions(
          items: gameTransaction,
          counts: gameTransaction.length,
        ),
        VSpaceBig(),

        /// RECOMMENDED PACKAGE
        PackageListSlider(
          title: 'Recomended Game Package',
          packageList: packageList,
          withCover: false,
        ),
        VSpace(),
        TopupListSlider(
          title: 'Recomended Game Topup',
          creditList: gameCredits.sublist(0, 5),
          category: 'game',
          creditType: CreditType.diamond,
        ),
        VSpaceBig()
      ]
    );
  }
}