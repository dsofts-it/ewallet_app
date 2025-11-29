import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/billing_layout.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvBilling extends StatefulWidget {
  const TvBilling({super.key});

  @override
  State<TvBilling> createState() => _TvBillingState();
}

class _TvBillingState extends State<TvBilling> with SingleTickerProviderStateMixin {
  final InputIdController _inputController = Get.put(InputIdController());

  @override
  void initState() {
    super.initState();
    _inputController.updateText('');
  }

  @override
  Widget build(BuildContext context) {
    final String vendorId = Get.arguments?['vendorId'] ?? '1';
    final Vendor vendor = tvVendors.firstWhere(
      (item) => item.id == vendorId,
      orElse: () => tvVendors[0]
    );

    return BillingLayout(
      name: vendor.name,
      image: vendor.banner ?? ImgApi.photo[102],
      child: Obx(() => _inputController.isValidInput.value ? BillingDetail(
        name: 'TV Subscription Billing',
        icon: CircleAvatar(
          radius: 26,
          backgroundColor: getCategory('tv').color.withValues(alpha: 0.5),
          child: Image.asset(getCategory('tv').image, width: 36,),
        )
      ) : NoData(
        image: ImgApi.promoTv,
        title: 'Pay TV Billing',
        desc: 'Type ID number to check your TV subscription billing',
      ))
    );
  }
}