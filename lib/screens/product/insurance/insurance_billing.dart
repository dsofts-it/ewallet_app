import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/layouts/billing_layout.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsuranceBilling extends StatefulWidget {
  const InsuranceBilling({super.key});

  @override
  State<InsuranceBilling> createState() => _InsuranceBillingState();
}

class _InsuranceBillingState extends State<InsuranceBilling> with SingleTickerProviderStateMixin {
  final InputIdController _inputController = Get.put(InputIdController());

  @override
  void initState() {
    super.initState();
    _inputController.updateText('');
  }

  @override
  Widget build(BuildContext context) {
    final String vendorId = Get.arguments?['vendorId'] ?? '1';
    final Vendor vendor = medicalVendors.firstWhere(
      (item) => item.id == vendorId,
      orElse: () => medicalVendors[0]
    );

    return BillingLayout(
      name: vendor.name,
      image: vendor.banner ?? ImgApi.photo[102],
      child: Obx(() => _inputController.isValidInput.value ? BillingDetail(
        name: 'Insurance Monthly Billing',
        icon: CircleAvatar(
          radius: 26,
          backgroundColor: getCategory('insurance').color.withValues(alpha: 0.5),
          child: Image.asset(getCategory('insurance').image, width: 40,),
        )
      ) : NoData(
        image: ImgApi.promoMedical,
        title: 'Pay Insurance Billing',
        desc: 'Type ID number to check your Insurance billing',
      ))
    );
  }
}