import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/widgets/user/auth_wrap.dart';
import 'package:ewallet_app/widgets/user/register_form.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        leading: BackIconButton(invert: true, onTap: () {
          Get.back();
        }),
        actions: [
          TextButton(
            onPressed: () {
            Get.toNamed(AppLink.login);
          },
            child: Row(
              children: [
                Text('LOGIN', style: ThemeText.subtitle2.copyWith(color: Colors.white)),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: Colors.white)
              ],
            )
          )
        ],
      ),
      body: const AuthWrap(content: RegisterForm())
    );
  }
}