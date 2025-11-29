import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/billing_layout.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetBilling extends StatefulWidget {
  const InternetBilling({super.key});

  @override
  State<InternetBilling> createState() => _InternetBillingState();
}

class _InternetBillingState extends State<InternetBilling> with SingleTickerProviderStateMixin {
  final InputIdController _inputController = Get.put(InputIdController());

  @override
  void initState() {
    super.initState();
    _inputController.updateText('');
  }

  @override
  Widget build(BuildContext context) {
    final String vendorId = Get.arguments?['vendorId'] ?? '1';
    final Vendor vendor = internetVendors.firstWhere(
      (item) => item.id == vendorId,
      orElse: () => internetVendors[0]
    );

    return BillingLayout(
      name: vendor.name,
      image: vendor.banner ?? ImgApi.photo[102],
      child: Obx(() => _inputController.isValidInput.value ? BillingDetail(
        name: 'Internet Monthly Billing',
        icon: CircleAvatar(
          radius: 26,
          backgroundColor: getCategory('internet').color.withValues(alpha: 0.5),
          child: Image.asset(getCategory('internet').image, width: 40,),
        )
      ) : NoData(
        image: ImgApi.promoInternet,
        title: 'Pay Internet Billing',
        desc: 'Type ID number to check your internet billing',
      ))
    );
  }
}