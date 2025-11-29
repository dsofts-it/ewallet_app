import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/product/package/package_grid.dart';
import 'package:ewallet_app/widgets/product/package/package_list.dart';
import 'package:ewallet_app/widgets/product/topup/topup_list.dart';
import 'package:ewallet_app/widgets/product/vendor/vendor_grid.dart';
import 'package:ewallet_app/widgets/product/vendor/vendor_list.dart';
import 'package:ewallet_app/widgets/tab_menu/tab_menu_swipe.dart';
import 'package:flutter/material.dart';

class MyFavoritesProducts extends StatefulWidget {
  const MyFavoritesProducts({super.key});

  @override
  State<MyFavoritesProducts> createState() => _MyFavoritesProductsState();
}

class _MyFavoritesProductsState extends State<MyFavoritesProducts>  with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Package> favoritedPackages = [educationPackages[3], mobilePackages[2], mobilePackages[9], gamePackages[3], gamePackages[9], gamePackages[12]];
    final List<Credit> favoritedVoucher = [appCredits[2], mobileCredits[4], electricCredits[4]];
    final List<Vendor> favoritedVendor = [vendorList[10], vendorList[50], vendorList[70], vendorList[7], vendorList[20], vendorList[30], vendorList[56], vendorList[21]];

    final bool wideScreen = ThemeBreakpoints.smUp(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ThemeSize.xs
            ),
            child: TabMenuSwipe(menus: ['Packages', 'Vouchers', 'Services'], tabController: _tabController)
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              wideScreen ? PackageGrid(packageItems: favoritedPackages, scaffoldKey: _scaffoldKey) : PackageList(packageItems: favoritedPackages, scaffoldKey: _scaffoldKey),
              TopupList(creditItems: favoritedVoucher, scaffoldKey: _scaffoldKey,),
              wideScreen ? VendorGrid(vendorList: favoritedVendor, purchaseRoute: AppLink.gamePurchase) : VendorList(items: favoritedVendor, purchaseRoute: AppLink.gamePurchase,)
            ]
          ),
        ),
        VSpaceBig(),
      ],
    );
  }
}