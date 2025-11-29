import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/controller/package_filter_controller.dart';
import 'package:ewallet_app/controller/product_filter_controller.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/purchase_cover_layout.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/filters/package_filter.dart';
import 'package:ewallet_app/widgets/filters/product_filter.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:ewallet_app/widgets/product/package/package_list_group.dart';
import 'package:ewallet_app/widgets/product/topup/topup_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobilePurchase extends StatefulWidget {
  const MobilePurchase({super.key});

  @override
  State<MobilePurchase> createState() => _MobilePurchaseState();
}

class _MobilePurchaseState extends State<MobilePurchase> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InputIdController _inputController = Get.put(InputIdController());
  final ScrollController _scrollLayout = ScrollController();
  final ScrollController _scrollGroupList = ScrollController();

  final PackageFilterController _filterPackageCtrl = Get.put(PackageFilterController());
  final ProductFilterController _filterProductCtrl = Get.put(ProductFilterController());

  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _noScroll = true;

  List<Package> _filteredPackages = mobilePackages;
  List<Credit> _filteredProduct = mobileCredits;

  @override
  void initState() {
    super.initState();
    /// TAB CONTROLLER
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.animation?.addListener(_handleTabSelection);
    _inputController.updateText(userAccount.phone);

    /// LOAD DATALIST
    _filterPackageCtrl.loadItems(mobilePackages);
    _filterProductCtrl.loadItems(mobileCredits);
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
    _scrollLayout.dispose();
    _scrollGroupList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> filterPackageTags = <String>['SMS & Call', 'Internet', 'Roaming'];
    final List<Vendor> filterVendorList = <Vendor>[mobileVendors[0], mobileVendors[1], mobileVendors[2], mobileVendors[3]];
    final double collapseThreshold = 220 - kToolbarHeight;

    _scrollLayout.addListener(() {
      setState(() {
        /// scroll to bottom
        if(_scrollLayout.offset > collapseThreshold) {
          _noScroll = false;
        }
      });
    });
    
    _scrollGroupList.addListener(() {
      setState(() {
        /// scroll to top
        if(_scrollGroupList.offset < 1) {
          _noScroll = true;
        }
      });
    });

    return PurchaseCoverLayout(
      scaffoldKey: _scaffoldKey,
      name: 'Mobile',
      headline: 'Stay Connected',
      desc: 'Top up your data and packages instantly, anywhere you go.',
      icon: ImgApi.icon3dMobile,
      background: ImgApi.mobileBg,
      color: getCategory('mobile').color,
      menus: <String>['Packages', 'Topup', 'Billing'],
      tabController: _tabController,
      scrollController: _scrollLayout,
      extendBottom: Container(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
        child: InputIdNumber(
          placeholder: 'Enter phone number or contact',
          helpText: null,
          label: 'Enter phone number',
          prefixIcon: Icon(Icons.person, color: Colors.black),
          suffixIcon: Icons.contact_phone_rounded,
          controller: _inputController.textEditingController,
          recentNumbers: ['081234567890', '012345678900', '09876543210',],
          withFilter: _currentTabIndex < 2,
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
        ),
      ),
      children: <Widget>[
        /// CONTENT
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              /// PACKAGES
              Obx(() => _inputController.isValidInput.value ? PackageListGroup(
                packageItems: _filteredPackages,
                scaffoldKey: _scaffoldKey,
                selectable: true,
                noScroll: _noScroll,
                scrollController: _scrollGroupList,
              ) : NoData(
                image: ImgApi.promoMobile,
                title: 'Search Packages',
                desc: 'Type phone number to explore available packages',
              )),
          
              // /// CREDITS
              Obx(() => _inputController.isValidInput.value ? TopupList(
                creditItems: _filteredProduct,
                scaffoldKey: _scaffoldKey,
                selectable: true
              ) : NoData(
                image: ImgApi.nodataVoucher,
                title: 'Topup Credit',
                desc: 'Type phone number to explore availeble credits',
              )),
              
              /// BILLINGS
              Obx(() => _inputController.isValidInput.value ? BillingDetail(
                name: 'Combo Mobile Postpaid',
                icon: CircleAvatar(
                  radius: 26,
                  backgroundColor: getCategory('mobile').color.withValues(alpha: 0.5),
                  child: Image.asset(getCategory('mobile').image, width: 40,),
                )
              ) : NoData(
                image: ImgApi.promoMobile,
                title: 'Pay mobile billing',
                desc: 'Type phone number to check your mobile billing',
              )),
            ],
          ),
        ),
      ],
    );
  }
}