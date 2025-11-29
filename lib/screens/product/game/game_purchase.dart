import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/controller/package_filter_controller.dart';
import 'package:ewallet_app/controller/product_filter_controller.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/purchase_layout.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/filters/package_filter.dart';
import 'package:ewallet_app/widgets/filters/product_filter.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:ewallet_app/widgets/product/package/package_list_group.dart';
import 'package:ewallet_app/widgets/product/topup/topup_list.dart';
import 'package:ewallet_app/widgets/product/voucher/voucher_grid_list.dart';
import 'package:ewallet_app/widgets/product/voucher/voucher_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamePurchase extends StatefulWidget {
  const GamePurchase({super.key});

  @override
  State<GamePurchase> createState() => _GamePurchaseState();
}

class _GamePurchaseState extends State<GamePurchase> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InputIdController _inputController = Get.put(InputIdController());
  final PackageFilterController _filterPackageCtrl = Get.put(PackageFilterController());
  final ProductFilterController _filterProductCtrl = Get.put(ProductFilterController());
  
  late TabController _tabController;
  int _currentTabIndex = 0;

  List<Package> _filteredPackages = gamePackages;
  List<Credit> _filteredProduct = gameCredits;

  @override
  void initState() {
    super.initState();
    /// TAB CONTROLLER
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.animation?.addListener(_handleTabSelection);
    _inputController.updateText(userAccount.username);

    /// LOAD DATALIST
    _filterPackageCtrl.loadItems(gamePackages);
    _filterProductCtrl.loadItems(gameCredits);
  }

  void _handleTabSelection() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
  }

  void _onFilterPackage() async {
    _filterPackageCtrl.onFilterPackage();
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      _filteredPackages = _filterPackageCtrl.filteredPackages;
    });
  }

  void _onFilterProduct() async {
    _filterProductCtrl.onFilterProduct();
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      _filteredProduct = _filterProductCtrl.filteredProduct;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String vendorId = Get.arguments?['vendorId'] ?? '2';
    final List<String> filterPackageTags = <String>['Skins', 'Event', 'Stickers'];
    final List<Vendor> filterVendorList = <Vendor>[gameVendors[0], gameVendors[1], gameVendors[2], gameVendors[3]];

    final Vendor vendor = gameVendors.firstWhere(
      (item) => item.id == vendorId,
      orElse: () => gameVendors[0]
    );

    return PurchaseLayout(
      scaffoldKey: _scaffoldKey,
      name: vendor.name,
      image: vendor.banner ?? ImgApi.photo[102],
      menus: <String>['Packages', 'Topup', 'Voucher'],
      tabController: _tabController,
      children: <Widget>[
        /// INPUT ID NUMBER
        Padding(
          padding: EdgeInsets.all(spacingUnit(1)),
          child: _currentTabIndex == 2 ? VoucherGuide() : Obx(() => InputIdNumber(
            placeholder: 'Enter your user ID',
            helpText: _inputController.infoText.value,
            prefixIcon: Icon(Icons.person, color: Colors.black),
            suffixIcon: Icons.switch_account,
            controller: _inputController.textEditingController,
            withFilter: true,
            onShowFilter: () {
              if (_currentTabIndex == 0) {
                showPackageFilter(context, _onFilterPackage, filterPackageTags, filterVendorList);
              } else {
                showProductFilter(context, _onFilterProduct, filterVendorList);
              }
            },
            onGetNumber: () {
              Get.toNamed(AppLink.searchId);
            },
          )),
        ),

        Expanded(child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            /// PACKAGES 
            PackageListGroup(
              packageItems: _filteredPackages,
              scaffoldKey: _scaffoldKey,
              selectable: true
            ),

            /// CREDITS
            TopupList(creditItems: _filteredProduct, scaffoldKey: _scaffoldKey, selectable: true),

            /// VOUCHERS
            VoucherGridList(creditItems: gameCredits, packageItems: gamePackages)
          ],
        )), 
      ]
    );
  }
}