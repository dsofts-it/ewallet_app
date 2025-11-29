import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/product/detail/package_detail.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDetailScreen extends StatelessWidget {
  const PackageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InputIdController inputController = Get.put(InputIdController());

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.md
        ),
        child: Column(children: [
          /// DETAIL
          Expanded(
            child: SingleChildScrollView(
              child: PackageDetail(
                name: 'Regular Internet Package',
                image: ImgApi.photo[181],
                category: 'mobile',
                description: 'Donec interdum commodo aliquet',
                price: 10,
                discount: 10,
                features: ['7 Days', '10GB'],
                isPromo: false,
                points: 100,
                vendor: vendorList[63],
              ),
            ),
          ),
          VSpaceShort(),
        
          /// INPUT ID
          Padding(
            padding: EdgeInsets.all(spacingUnit(2)),
            child: InputIdNumber(
              placeholder: 'Enter User ID',
              helpText: 'Input your user ID to continue',
              prefixIcon: Icon(Icons.person, color: Colors.black),
              suffixIcon: Icons.contact_phone_rounded,
              controller: inputController.textEditingController,
              onGetNumber: () {
                Get.toNamed(AppLink.searchId);
              },
            ),
          ),
        
          /// BUY BUTTON
          Padding(
            padding: EdgeInsets.all(spacingUnit(2)),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Regular Internet Package', style: ThemeText.subtitle2, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('${userAccount.currencySymbol}9', style: ThemeText.title2)
                ]),
              ),
              SizedBox(width: spacingUnit(1)),
              Obx(() => FilledButton(
                onPressed: inputController.isValidInput.value ? () {
                  Get.toNamed(AppLink.payment);
                } : null,
                style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                child: Text('BUY NOW', style: ThemeText.subtitle2)
              )),
            ]),
          ),
          VSpace(),
        ]),
      ),
    );
  }
}