import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplitBillIntro extends StatefulWidget {
  const SplitBillIntro({super.key});

  @override
  State<SplitBillIntro> createState() => _SplitBillIntroState();
}

class _SplitBillIntroState extends State<SplitBillIntro> {
  bool _showDoneBtn = false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(spacingUnit(2)),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ThemeSize.xs
          ),
          child: ListView(shrinkWrap: true, children: [
            Center(child: Image.asset(ImgApi.splitBill, width: 200)),
            VSpaceShort(),
            Text('Easy Split Billing', textAlign: TextAlign.center, style: ThemeText.title),
            VSpaceShort(),
            Text('This is a convenient way to handle group expenses, such as splitting a restaurant bill among friends', textAlign: TextAlign.center, style: ThemeText.paragraph,),
            VSpace(),
            AppTextField(
              label: 'Enter total amount of bill',
              hint: 'Total amount',
              type: TextInputType.number,
              prefix: Padding(
                padding: EdgeInsets.symmetric(vertical: spacingUnit(1)),
                child: Text(userAccount.currencySymbol, textAlign: TextAlign.center, style: ThemeText.subtitle),
              ),
              suffix: _showDoneBtn ? TextButton(
                onPressed: () {
                  setState(() {
                    _showDoneBtn = false;
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                child: Text('DONE', style: ThemeText.paragraphBold.copyWith(color: colorScheme(context).onInverseSurface),)
              ) : null,
              onChanged: (String val) {
                setState(() {
                  _showDoneBtn = true;
                });
              },
            ),
            VSpace(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: ThemeButton.btnBig.merge(ThemeButton.primary),
                onPressed: () {
                  Get.toNamed(AppLink.splitBill);
                },
                child: Text('CONTINUE', style: ThemeText.subtitle),
              ),
            ),
            VSpace(),
            Text('OR', textAlign: TextAlign.center, style: ThemeText.paragraph.copyWith(color: colorScheme(context).onSurface)),
            VSpace(),
            TextButton(
              onPressed: () {
                Get.toNamed(AppLink.splitBill);
              },
              child: Text('SKIP AND DECIDE LATER', style: ThemeText.paragraphBold.copyWith(color: colorScheme(context).onSurface))
            ),
          ]),
        ),
      )
    );
  }
}