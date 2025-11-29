import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:get/route_manager.dart';

class SettingPin extends StatefulWidget {
  const SettingPin({super.key});

  @override
  State<SettingPin> createState() => _SettingPinState();
}

class _SettingPinState extends State<SettingPin> {
  bool _pinActive = false;
  bool _bioMetrik = false;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.md
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(spacingUnit(2)),
              child: PaperCard(
                flat: true,
                content: Padding(
                  padding: EdgeInsets.all(spacingUnit(2)),
                  child: Column(children: [
                    ListTile(
                      title: Text('Enable PIN', style: ThemeText.paragraph,),
                      trailing: Transform.scale(
                        scale: 0.75,
                        alignment: Alignment.centerRight,
                        child: Switch(
                          padding: EdgeInsets.zero,
                          onChanged: (val) {
                            setState(() {
                              _pinActive = val;
                            });
                          },
                          value: _pinActive,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Biometrik', style: ThemeText.paragraph,),
                      trailing: Transform.scale(
                        scale: 0.75,
                        alignment: Alignment.centerRight,
                        child: Switch(
                          padding: EdgeInsets.zero,
                          onChanged: (val) {
                            setState(() {
                              _bioMetrik = val;
                            });
                          },
                          value: _bioMetrik,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Change PIN', style: ThemeText.paragraph,),
                      onTap: () {
                        Get.toNamed(AppLink.paymentPin);
                      },
                      trailing: Padding(
                        padding: EdgeInsets.only(right: spacingUnit(1)),
                        child: Icon(Icons.arrow_forward_ios, size: 12, color: ThemePalette.primaryMain),
                      ),
                    ),
                    ListTile(
                      title: Text('Forgot PIN', style: ThemeText.paragraph,),
                      onTap: () {
                        Get.toNamed(AppLink.resetPassword);
                      },
                      trailing: Padding(
                        padding: EdgeInsets.only(right: spacingUnit(1)),
                        child: Icon(Icons.arrow_forward_ios, size: 12, color: ThemePalette.primaryMain),
                      ),
                    )
                  ]),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}