import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:ewallet_app/widgets/search/search_input_btn.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:ewallet_app/widgets/wallet/request/personal_qr_link.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RequestMenu extends StatelessWidget {
  const RequestMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PaperCard(
      flat: true,
      content: Padding(
        padding: EdgeInsetsGeometry.all(spacingUnit(2)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// INPUT CONTACT
          TitleBasic(title: 'Request to a Friend', size: 'small',),
          Padding(
            padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
            child: SearchInputBtn(location: AppLink.searchContact, nextRoute: AppLink.requestPersonal, hasBorder: true, title: 'Find name or phone number'),
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
                        Get.toNamed(AppLink.requestPersonal);
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
          TitleBasic(title: 'More Request', size: 'small',),
          SizedBox(height: spacingUnit(2),),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: _gradientBtn(context, Icons.payments, 'Split Bill', ThemePalette.gradientMixedAllLight, () {
              Get.toNamed(AppLink.splitBillIntro);
            })),
            SizedBox(width: spacingUnit(1)),
            Expanded(child: _gradientBtn(context, Icons.qr_code, 'Show QR', ThemePalette.gradientPrimaryLight, () {
              showMyQrLink(context, 0);
            })),
            SizedBox(width: spacingUnit(1)),
            Expanded(child: _gradientBtn(context, Icons.link, 'Payment Link', ThemePalette.gradientMixedLight, () {
              showMyQrLink(context, 1);
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
          child: Column(children: [
            Icon(icon, size: 24, color: colorScheme(context).onSurface),
            SizedBox(height: 4,),
            Text(text, textAlign: TextAlign.center, style: ThemeText.caption.copyWith(color: colorScheme(context).onSurface))
          ])
        ),
      ),
    );
  }
}