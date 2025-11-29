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

class TvListScreen extends StatelessWidget {
  const TvListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ProductLayout(
      title: 'TV',
      headline: 'Your Shows, Your Way',
      searchTitle: 'Search TV Subscriptions',
      desc: 'Recharge and pay for TV subscriptions instantly..',
      icon: ImgApi.icon3dTv,
      background: ImgApi.tvBg,
      color: getCategory('tv').color,
      children: <Widget>[
        VSpaceShort(),
        /// VENDOR LIST
        VendorGrid(maxLength: 20, vendorList: tvVendors, purchaseRoute: AppLink.tvBilling),
        VSpace(),
        BillingList(
          items: tvBilling,
          counts: tvBilling.length,
          title: 'Active Billings',
          subtitle: 'Please pay your billing before due date'
        ),
        VSpaceBig(),
      ]
    );
  }
}