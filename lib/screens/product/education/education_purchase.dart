import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/controller/package_filter_controller.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/purchase_layout.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/filters/package_filter.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:ewallet_app/widgets/product/package/package_list_group.dart';
import 'package:ewallet_app/widgets/product/voucher/voucher_grid_list.dart';
import 'package:ewallet_app/widgets/product/voucher/voucher_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationPurchase extends StatefulWidget {
  const EducationPurchase({super.key});

  @override
  State<EducationPurchase> createState() => _EducationPurchaseState();
}

class _EducationPurchaseState extends State<EducationPurchase> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InputIdController _inputController = Get.put(InputIdController());
  final PackageFilterController _filterPackageCtrl = Get.put(PackageFilterController());

  late TabController _tabController;
  int _currentTabIndex = 0;

  List<Package> _filteredPackages = educationPackages;

  @override
  void initState() {
    super.initState();
    /// TAB CONTROLLER
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.animation?.addListener(_handleTabSelection);
    _inputController.updateText(userAccount.username);

    /// LOAD DATALIST
    _filterPackageCtrl.loadItems(educationPackages);
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String vendorId = Get.arguments?['vendorId'] ?? '6';
    final List<String> filterPackageTags = <String>['Finance', 'Learn AI', 'Math', 'English',];
    final List<Vendor> filterVendorList = <Vendor>[educationVendors[0], educationVendors[1], educationVendors[2], educationVendors[3]];

    final Vendor vendor = educationVendors.firstWhere(
      (item) => item.id == vendorId,
      orElse: () => educationVendors[0]
    );

    return PurchaseLayout(
      scaffoldKey: _scaffoldKey,
      name: vendor.name,
      image: vendor.banner ?? ImgApi.photo[102],
      menus: <String>['Plans', 'Billings', 'Vouchers'],
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
            withFilter: _currentTabIndex == 0,
            onShowFilter: () {
              showPackageFilter(context, _onFilterPackage, filterPackageTags, filterVendorList);
            },
            onGetNumber: () {
              Get.toNamed(AppLink.searchId);
            },
          )),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              /// PACKAGE
              PackageListGroup(
                packageItems: _filteredPackages,
                scaffoldKey: _scaffoldKey,
                selectable: true
              ),
              
              /// BILLINGS
              Obx(() => _inputController.isValidInput.value ? BillingDetail(
                name: 'Course Monthly Billing',
                icon: CircleAvatar(
                  radius: 26,
                  backgroundColor: getCategory('education').color.withValues(alpha: 0.5),
                  child: Image.asset(getCategory('education').image, width: 40,),
                )
              ) : NoData(
                image: ImgApi.promoEducation,
                title: 'Pay Courses Billing',
                desc: 'Type ID number to check your Courses billing',
              )),

              // Vouchers
              VoucherGridList(creditItems: educationCredits, packageItems: educationPackages)
            ],
          )
        ),
      ]
    );
  }
}