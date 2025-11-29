import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/utils/check_platforms.dart';
import 'package:ewallet_app/widgets/profile/profile_action_button.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/image_viewer.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    super.key,
    required this.avatar,
    required this.name,
    required this.id,
    this.bottom
  });

  final String avatar;
  final String name;
  final String id;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      /// AVATAR
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: colorScheme(context).surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [BoxShadow(
                color: colorScheme(context).surfaceContainerLowest,
                blurRadius: 0.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 2),
              )],
            ),
          ),
          Hero(
            tag: avatar,
            child: GestureDetector(
              onTap: () {
                Get.to(() => ImageViewer(img: avatar));
              },
              child: isUrl(avatar) ?
                AvatarNetwork(
                  radius: 32,
                  backgroundImage: avatar,
                  backgroundColor: ThemePalette.primaryLight,
                )
                : CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(avatar),
                  backgroundColor: ThemePalette.primaryLight,
                ),
            ),
          )
        ],
      ),

      /// PROFILE INFORMATION
      Container(
        color: colorScheme(context).surface,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(3)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          /// NAME
          Text(name, style: ThemeText.title2),
          const SizedBox(height: 4),
          Text(id, style: ThemeText.subtitle2.copyWith(color: colorScheme(context).onSurfaceVariant)),
          const VSpaceShort(),

          /// OPTIONS
          ProfileOptions(),
          const VSpace(),
          bottom ?? Container(),
          
          const VSpace(),
        ]),
      ),
    ]);
  }
}