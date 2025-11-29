import 'package:ewallet_app/utils/check_platforms.dart';
import 'package:ewallet_app/widgets/decorations/fire_deco.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:get/route_manager.dart';

class AuthWrap extends StatelessWidget {
  const AuthWrap({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;
    
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: ThemePalette.gradientPrimaryDark
          ),
          child: Container(
            margin: EdgeInsets.only(top: isOnDesktopAndWeb() ? spacingUnit(10) : spacingUnit(15)),
            padding: EdgeInsets.symmetric(horizontal: spacingUnit(4)),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              color: isDark ? ThemePalette.defaultDark : ThemePalette.paperLight
            ),
            child: Center(child: content)
          ),
        ),
        FireDeco()
      ],
    );
  }
}