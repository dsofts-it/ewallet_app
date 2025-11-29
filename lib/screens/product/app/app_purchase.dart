import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/purchase_layout.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:ewallet_app/widgets/product/package/package_grid.dart';
import 'package:ewallet_app/widgets/product/topup/topup_grid.dart';
import 'package:ewallet_app/widgets/product/voucher/voucher_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPurchase extends StatefulWidget {
  const AppPurchase({super.key});

  @override
  State<AppPurchase> createState() => _AppPurchaseState();
}

class _AppPurchaseState extends State<AppPurchase> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InputIdController _inputController = Get.put(InputIdController());

  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    /// TAB CONTROLLER
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.animation?.addListener(_handleTabSelection);
    _inputController.updateText(userAccount.username);
  }

  void _handleTabSelection() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String vendorId = Get.arguments?['vendorId'] ?? '6';
    final Vendor vendor = appVendors.firstWhere(
      (item) => item.id == vendorId,
      orElse: () => appVendors[0]
    );

    return PurchaseLayout(
      scaffoldKey: _scaffoldKey,
      name: vendor.name,
      image: vendor.banner ?? ImgApi.photo[102],
      menus: <String>['Plans', 'Credit'],
      tabController: _tabController,
      children: <Widget>[
        Container(
          color: colorScheme(context).surfaceContainerLow,
          padding: EdgeInsets.all(spacingUnit(1)),
          child: _currentTabIndex == 2 ? VoucherGuide() : Obx(() => InputIdNumber(
            placeholder: 'Enter your user ID',
            helpText: _inputController.infoText.value,
            prefixIcon: Icon(Icons.person, color: Colors.black),
            suffixIcon: Icons.switch_account,
            controller: _inputController.textEditingController,
            onGetNumber: () {
              Get.toNamed(AppLink.searchId);
            },
          )),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              /// PLANS
              PackageGrid(
                packageItems: appPackages,
                scaffoldKey: _scaffoldKey,
                selectable: true
              ),
          
              /// CREDITS
              TopupGrid(creditItems: appCredits, scaffoldKey: _scaffoldKey, selectable: true),
            ],
          ),
        ),
      ]
    );
  }
}