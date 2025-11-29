import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/billing.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/product_layout.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/product/billing/billing_list.dart';
import 'package:ewallet_app/widgets/product/vendor/vendor_grid.dart';
import 'package:flutter/material.dart';

class InsuranceListScreen extends StatelessWidget {
  const InsuranceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductLayout(
      title: 'Insurance',
      headline: 'Protection Made Simple',
      searchTitle: 'Search Insurance Services',
      desc: 'Pay your insurance bills securely in just a few clicks.',
      icon: ImgApi.icon3dMedical,
      background: ImgApi.medicalBg,
      color: getCategory('insurance').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(maxLength: 20, vendorList: medicalVendors, purchaseRoute: AppLink.insuranceBilling),
        VSpace(),
        BillingList(
          items: insuranceBilling,
          counts: insuranceBilling.length,
          title: 'Active Billings',
          subtitle: 'Please pay your billing before due date'
        ),
        VSpaceBig(),
      ]
    );
  }
}