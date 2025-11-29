
import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedCreditModel with ChangeNotifier {
  Credit? selectedCredit;

  void selectCredit(Credit item) {
    selectedCredit = item;
    notifyListeners();
  }
}

class SelectedPackageModel with ChangeNotifier {
  Package? selectedPackage;

  void selectPackage(Package item) {
    selectedPackage = item;
    notifyListeners();
  }
}

class CreditPriceDetails extends StatelessWidget {
  const CreditPriceDetails({super.key, required this.notifier});

  final SelectedCreditModel notifier;

  @override
  Widget build(BuildContext context) {
    final InputIdController inputController = Get.put(InputIdController());

    return Center(
      child: ListenableBuilder(
        listenable: notifier,
        builder: (BuildContext context, Widget? child) {
          return Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${notifier.selectedCredit!.amount.toStringAsFixed(0)} ${notifier.selectedCredit!.unit}', style: ThemeText.subtitle2, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('${userAccount.currencySymbol}${notifier.selectedCredit!.price.toStringAsFixed(2)}', style: ThemeText.title2)
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
          ]);
        },
      ),
    );
  }
}

class PackagePriceDetails extends StatelessWidget {
  const PackagePriceDetails({super.key, required this.notifier});

  final SelectedPackageModel notifier;

  @override
  Widget build(BuildContext context) {
    final InputIdController inputController = Get.put(InputIdController());

    return Center(
      child: ListenableBuilder(
        listenable: notifier,
        builder: (BuildContext context, Widget? child) {
          return Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(notifier.selectedPackage!.name, style: ThemeText.subtitle2, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('${userAccount.currencySymbol}${notifier.selectedPackage!.price}', style: ThemeText.title2)
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
          ]);
        },
      ),
    );
  }
}