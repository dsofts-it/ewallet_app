import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ChatSupportInput extends StatelessWidget {
  const ChatSupportInput({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppLink.chatSupport);
      },
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          boxShadow: [ThemeShade.shadeSoft(context)],
          borderRadius: ThemeRadius.xbig,
          gradient: ThemePalette.gradientMixedAllMain
        ),
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(vertical: spacingUnit(1), horizontal: spacingUnit(2)),
          decoration: BoxDecoration(
            color: colorScheme(context).surface,
            borderRadius: ThemeRadius.xbig,
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: ThemePalette.primaryMain,
              backgroundImage: AssetImage(ImgApi.logoApps),
            ),
            SizedBox(width: spacingUnit(1)),
            Expanded(child: Text('Ask to Support here', style: ThemeText.subtitle2)),
            SizedBox(width: spacingUnit(1)),
            Icon(Icons.message_outlined, color: colorScheme(context).onTertiaryContainer, size: 18),
          ])
        ),
      ),
    );
  }
}