import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/ui/layouts/purchase_cover_layout.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:ewallet_app/widgets/product/topup/topup_grid.dart';
import 'package:ewallet_app/widgets/product/voucher/voucher_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricityPurchase extends StatefulWidget {
  const ElectricityPurchase({super.key});

  @override
  State<ElectricityPurchase> createState() => _ElectricityPurchaseState();
}

class _ElectricityPurchaseState extends State<ElectricityPurchase> with SingleTickerProviderStateMixin {
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
    _inputController.updateText(userAccount.idCard);
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

    return PurchaseCoverLayout(
      scaffoldKey: _scaffoldKey,
      name: 'Electricity',
      headline: 'Power Up Your Life',
      desc: 'Pay your electricity tokens and bills anytime, anywhere.',
      icon: ImgApi.icon3dElectric,
      background: ImgApi.electricBg,
      color: getCategory('electric').color,
      menus: <String>['Credit', 'Billing'],
      tabController: _tabController,
      extendBottom: Container(
        color: colorScheme(context).surfaceContainerLow,
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
        child: _currentTabIndex == 2 ? VoucherGuide() : InputIdNumber(
          placeholder: 'Enter your account ID',
          helpText: null,
          label: 'Enter your account ID',
          prefixIcon: Icon(Icons.person, color: Colors.black),
          suffixIcon: Icons.switch_account,
          controller: _inputController.textEditingController,
          recentNumbers: ['12345678901', '09876543210', '135689086421',],
          onGetNumber: () {
            Get.toNamed(AppLink.searchId);
          },
        ),
      ),
      children: <Widget>[
        /// CONTENT
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              /// TOPUP
              TopupGrid(
                creditItems: electricCredits,
                scaffoldKey: _scaffoldKey,
                selectable: true
              ),

              /// BILLING
              Obx(() => _inputController.isValidInput.value ? BillingDetail(
                name: 'Electricity Monthly Billing',
                icon: CircleAvatar(
                  radius: 20,
                  backgroundColor: getCategory('electric').color.withValues(alpha: 0.5),
                  child: Image.asset(getCategory('electric').image, width: 32,),
                )
              ) : NoData(
                image: ImgApi.promoElectric,
                title: 'Pay Electricity Billing',
                desc: 'Type ID number to check your Electricity billing',
              ))
            ],
          ),
        )
      ],
    );
  }
}