import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/widgets/user/auth_wrap.dart';
import 'package:ewallet_app/widgets/user/otp_form.dart';

class OtpPin extends StatelessWidget {
  const OtpPin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        leading: BackIconButton(
          invert: true,
          onTap: () {
            Get.back();
          },
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.toNamed(AppLink.helpSupport);
            },
            style: ThemeButton.btnMedium.merge(ThemeButton.outlinedWhite()),
            child: Row(
              children: [
                Icon(Icons.headset_mic, color: Colors.white),
                const SizedBox(width: 4),
                Text('Help and Support'),
              ],
            )
          )
        ],
      ),
      body: const AuthWrap(content: OtpForm())
    );
  }
}