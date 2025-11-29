import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/product/billing/purchase_list.dart';
import 'package:ewallet_app/widgets/decorations/zigzag_decoration.dart';
import 'package:get/route_manager.dart';

class BillingDetail extends StatelessWidget {
  const BillingDetail({
    super.key,
    this.icon,
    required this.name,
    this.withBtn = true,
    this.lightBg = false
  });

  final Widget? icon;
  final String name;
  final bool withBtn;
  final bool lightBg;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(
          children: [
            VSpaceShort(),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
                    child: ClipPath(
                      clipper: ZigzagClipper(),
                      child: Container(
                        color: lightBg ? colorScheme(context).surface : colorScheme(context).surfaceDim,
                        height: 20,
                        width: MediaQuery.of(context).size.width - spacingUnit(4),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
                      decoration: BoxDecoration(
                        color: lightBg ? colorScheme(context).surface : colorScheme(context).surfaceDim,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
                        child: PurchaseList(title: name, icon: icon),
                      )
                    ),
                  ),
                  Transform.flip(
                    flipY: true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
                      child: ClipPath(
                        clipper: ZigzagClipper(),
                        child: Container(
                          color: lightBg ? colorScheme(context).surface : colorScheme(context).surfaceDim,
                          height: 20,
                          width: MediaQuery.of(context).size.width - spacingUnit(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
            /// BUTTON
            withBtn ? Container(
              width: double.infinity,
              padding: EdgeInsets.all(spacingUnit(2)),
              child: FilledButton(
                onPressed: () {
                  Get.toNamed(AppLink.payment);
                },
                style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                child: Text('CONTINUE', style: ThemeText.subtitle2)
              ),
            ) : Container(),
            const VSpace(),
          ],
        ),
      ),
    );
  }
}