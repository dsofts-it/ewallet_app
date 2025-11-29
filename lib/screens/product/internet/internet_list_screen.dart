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

class InternetListScreen extends StatelessWidget {
  const InternetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ProductLayout(
      title: 'Internet',
      headline: 'Always Online',
      searchTitle: 'Search Internet Provider or Subscription',
      desc: 'Pay broadband and Wi-Fi bills hassle-free.',
      icon: ImgApi.icon3dInternet,
      background: ImgApi.internetBg,
      color: getCategory('internet').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(maxLength: 20, vendorList: internetVendors, purchaseRoute: AppLink.internetBilling),
        VSpace(),
        BillingList(
          items: internetBilling,
          counts: internetBilling.length,
          title: 'Active Billings',
          subtitle: 'Please pay your billing before due date'
        ),
        VSpaceBig(),
      ]
    );
  }
}