import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/decorations/fire_deco.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/user/auth_options.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool _openAuthOpt = false;

  void _showModal(Widget content) {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return content;
      },
      backgroundColor: colorScheme(context).surface
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    setState(() {
      _openAuthOpt = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackIconButton(onTap: () {
          Get.back();
        }),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: colorScheme(context).surface,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme(context).surface,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.75],
              colors: [
                isDark ? colorScheme(context).surfaceContainerLow : ThemePalette.secondaryLight,
                colorScheme(context).primaryContainer
              ]
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: FireDeco(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Opacity(
                    opacity: isDark ? 0.25 : 1,
                    child: Image.asset(
                      ImgApi.welcomeBg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -100,
                bottom: -150,
                child: Image.asset(ImgApi.welcomeDeco1, width: 400,),
              ),
              Positioned(
                right: -100,
                top: 50,
                child: Image.asset(ImgApi.welcomeDeco2, width: 200,),
              ),
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ThemeSize.sm
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spacingUnit(3)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    
                      /// TEXT
                      Text('Welcome to ${branding.name}', style: ThemeText.title.copyWith(fontSize: 48, color: colorScheme(context).onPrimaryContainer)),
                      const VSpaceShort(),
                      Text(branding.title, style: ThemeText.title2.copyWith(fontWeight: FontWeight.normal)),
                      const VSpaceBig(),
                    
                      /// BUTTONS
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              _openAuthOpt = true;
                            });
                            _showModal(const Wrap(
                              children: [
                                AuthOptions()
                              ],
                            ));
                          },
                          style: ThemeButton.btnBig.merge(ThemeButton.primary),
                          child: Text('REGISTER', style: ThemeText.title2)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: spacingUnit(3)),
                        child: const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Expanded(child: LineList()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Already have account?', style: TextStyle(fontSize: 18)),
                          ),
                          Expanded(child: LineList()),
                        ])
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              _openAuthOpt = true;
                            });
                            _showModal(const Wrap(
                              children: [
                                AuthOptions(isLogin: true,)
                              ],
                            ));
                          },
                          style: ThemeButton.btnBig.merge(ThemeButton.black),
                          child: Text('LOGIN', style: ThemeText.title2)
                        ),
                      ),
                      const VSpaceBig(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: _openAuthOpt ? 200 : 0,
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
