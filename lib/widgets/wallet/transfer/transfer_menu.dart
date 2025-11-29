import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:ewallet_app/widgets/search/search_input_btn.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class TransferMenu extends StatelessWidget {
  const TransferMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PaperCard(
      flat: true,
      content: Padding(
        padding: EdgeInsetsGeometry.all(spacingUnit(2)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// INPUT CONTACT
          TitleBasic(title: 'Send to ${branding.name} Account', size: 'small',),
          Padding(
            padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
            child: SearchInputBtn(location: AppLink.searchContact, nextRoute: AppLink.transferPersonal, hasBorder: true, title: 'Find name or phone number'),
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
              separatorBuilder: (BuildContext context, int index) => SizedBox(width: spacingUnit(1)),
              itemBuilder: (context, index) {
                final user = userList[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppLink.transferPersonal);
                      },
                      child: AvatarNetwork(
                        radius: 16,
                        backgroundImage: user.avatar,
                      ),
                    ),
                    SizedBox(height: spacingUnit(1)),
                    Text(user.name, style: ThemeText.caption),
                  ],
                );
              },
            ),
          ),
          VSpace(),

          /// ALL TRANSFER MENU
          TitleBasic(title: 'More Transfer', size: 'small',),
          SizedBox(height: spacingUnit(2),),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: _gradientBtn(context, Icons.account_balance, 'Bank Transfer', ThemePalette.gradientMixedAllLight, () {
              Get.toNamed(AppLink.transferBank);
            })),
            SizedBox(width: spacingUnit(1)),
            Expanded(child: _gradientBtn(context, Icons.download, 'Withdraw', ThemePalette.gradientMixedLight, () {
              Get.toNamed(AppLink.withdraw);
            }))
          ]),
          SizedBox(height: spacingUnit(1)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: _gradientBtn(context, Icons.qr_code, 'Upload QR', ThemePalette.gradientPrimaryLight, () {})),
            SizedBox(width: spacingUnit(1)),
            Expanded(child: _gradientBtn(context, Icons.qr_code_scanner, 'Scan QR', ThemePalette.gradientSecondaryLight, () {
              Get.toNamed(AppLink.scanqr);
            })),
          ]),
        ]),
      )
    );
  }

  Widget _gradientBtn(
    BuildContext context,
    IconData icon, String text, Gradient gradient,
    Function() onTap
  ) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: ThemeRadius.medium,
        gradient: gradient
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorScheme(context).surface,
        ),
        child: FilledButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 60),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Row(children: [
            Icon(icon, size: 24, color: colorScheme(context).onSurface),
            SizedBox(width: 4,),
            Text(text, style: ThemeText.paragraphBold.copyWith(color: colorScheme(context).onSurface))
          ])
        ),
      ),
    );
  }
}