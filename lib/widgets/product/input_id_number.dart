import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:get/route_manager.dart';

class InputIdNumber extends StatelessWidget {
  const InputIdNumber({
    super.key,
    this.label,
    this.placeholder = '08xxxxxxxx',
    this.helpText = 'Enter your mobile number to select a product',
    this.onGetNumber,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.withFilter = false,
    this.recentNumbers,
    this.onShowFilter
  });

  final String? label;
  final String? placeholder;
  final String? helpText;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onGetNumber;
  final TextEditingController? controller;
  final bool withFilter;
  final List<String>? recentNumbers;
  final Function()? onShowFilter;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return PaperCard(
      flat: !isDark,
      content: Padding(
        padding: EdgeInsets.all(spacingUnit(1)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// NUMBER INPUT
          label != null ? Text(label!, style: ThemeText.caption,) : Container(),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: prefixIcon ?? Icon(Icons.phone_android, color: Colors.black),
                    suffixIcon: IconButton(onPressed: onGetNumber, icon: Icon(suffixIcon ?? Icons.contact_phone, color: ThemePalette.primaryMain)),
                    hintText: placeholder,
                    helperText: helpText,
                    fillColor: ThemePalette.primaryLight,
                    filled: true,
                    hintStyle: TextStyle(color:Colors.grey[700]),
                    border: OutlineInputBorder(
                      borderRadius: ThemeRadius.medium,
                      borderSide: BorderSide(
                        width: 1,
                        color: colorScheme(context).outline
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: ThemeRadius.medium,
                      borderSide: BorderSide(
                        width: 1,
                        color: colorScheme(context).outline
                      )
                    ),
                  ),
                ),
              ),
              withFilter ? Padding(
                padding: EdgeInsets.only(top: 4, left: spacingUnit(1)),
                child: IconButton(
                  onPressed: onShowFilter,
                  style: ThemeButton.primary,
                  icon: Icon(Icons.tune),
                ),
              ) : SizedBox.shrink()
            ],
          ),
          SizedBox(height: spacingUnit(1)),
          if (recentNumbers != null && recentNumbers!.isNotEmpty)
            SizedBox(
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recentNumbers!.length,
                separatorBuilder: (context, index) => SizedBox(width: spacingUnit(1)),
                itemBuilder: (context, index) {
                  final number = recentNumbers![index];
                  return OutlinedButton(
                    style: ThemeButton.btnSmall.merge(ThemeButton.outlinedDefault(context)),
                    onPressed: () {
                      controller?.text = number;
                    },
                    child: Text(number, style: ThemeText.caption),
                  );
                },
              ),
            )
          else
            SizedBox.shrink(),
        ]),
      )
    );
  }
}