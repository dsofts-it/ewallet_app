import 'package:ewallet_app/app/app_link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SupportMenu extends StatelessWidget {
  const SupportMenu({super.key});

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri urlBlog = Uri.parse('https://verselion.ux-maestro.com/en/blog/');

    return Container(
      padding: EdgeInsets.only(
        left: spacingUnit(2),
        right: spacingUnit(2),
        top: spacingUnit(4),
        bottom: spacingUnit(2)
      ),
      decoration: BoxDecoration(
        color: colorScheme(context).primaryContainer
      ),
      child: Row(children: [
        Expanded(
          child: _gradientBtn(context, ImgApi.iconGrdMessage, 'Message Admin', ThemePalette.gradientMixedAllLight, () {
            Get.toNamed(AppLink.contact);
          }),
        ),
        SizedBox(width: spacingUnit(1)),
        Expanded(
          child: _gradientBtn(context, ImgApi.iconGrdFaq, 'FAQ', ThemePalette.gradientMixedMain, () {
            Get.toNamed(AppLink.faq);
          }),
        ),
        SizedBox(width: spacingUnit(1)),
        Expanded(
          child: _gradientBtn(context, ImgApi.iconGrdBlog, 'News & Blog', ThemePalette.gradientPrimaryLight, () {
            _launchUrl(urlBlog);
          }),
        ),
      ]),
    );
  }

  Widget _gradientBtn(
    BuildContext context,
    String icon, String text, Gradient gradient,
    Function() onTap
  ) {
    return Container(
      height: 110,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: ThemeRadius.big,
        gradient: gradient
      ),
      child: Container(
        padding: EdgeInsets.all(spacingUnit(1)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(icon, width: 38),
            SizedBox(height: 4),
            Text(text, textAlign: TextAlign.center, style: ThemeText.caption.copyWith(color: colorScheme(context).onSurface, fontWeight: FontWeight.bold))
          ])
        ),
      ),
    );
  }
}