import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/product/detail/product_detail.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

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
              child: ProductDetail(
                amount: 10,
                category: 'entertainment',
                price: 10,
                description: '3 days',
                discount: 10,
                icon: Icons.motion_photos_on,
                isPromo: true,
                points: 100,
                thumb: ImgApi.photo[288],
                vendor: vendorList[27],
                type: CreditType.coin,
                unit: 'coins'
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
                  Text('10 Coins', style: ThemeText.subtitle2, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('${userAccount.currencySymbol}9', style: ThemeText.title2)
                ]),
              ),
              SizedBox(width: spacingUnit(1)),
              Obx(() => FilledButton(
                onPressed: inputController.isValidInput.value ? () {
                  Get.toNamed(AppLink.payment);
                } : null,
                style: ThemeButton.btnBig.merge(ThemeButton.primary),
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