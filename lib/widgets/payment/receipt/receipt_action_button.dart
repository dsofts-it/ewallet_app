import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ReceiptActionButton extends StatefulWidget {
  const ReceiptActionButton({super.key});

  @override
  State<ReceiptActionButton> createState() => _ReceiptActionButtonState();
}

class _ReceiptActionButtonState extends State<ReceiptActionButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(spacingUnit(1)),
      constraints: BoxConstraints(
        maxWidth: ThemeSize.sm
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        InkWell(
          onTap: () {
            setState(() {
              _isLiked = !_isLiked;
            });
          },
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              alignment: Alignment.center,
                children: [
                CircleAvatar(
                  backgroundColor: ThemePalette.tertiaryLight,
                  radius: 16,
                ),
                _isLiked ? Icon(Icons.favorite, size: 20, color: ThemePalette.tertiaryDark) : Icon(Icons.favorite_border, size: 20, color: ThemePalette.tertiaryDark),
              ],
            ),
            const SizedBox(height: 4),
            Text('Add to Favorite', style: ThemeText.caption)
          ]),
        ),
        InkWell(
          onTap: () {},
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ThemePalette.primaryLight,
                  radius: 16,
                ),
                Transform.flip(
                  flipX: true,
                  child: Icon(Icons.reply_rounded, size: 20, color: ThemePalette.primaryDark)
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Share', style: ThemeText.caption)
          ]),
        ),
        InkWell(
          onTap: () {
            confirmDialog(
              context,
              title: 'Save Number',
              content: AppTextField(label: 'Name', onChanged: (_) {}),
              confirmAction: () {
                Navigator.of(context).pop();
              },
              confirmText: 'Save'
            );
          },
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ThemePalette.secondaryLight,
                  radius: 16,
                ),
                Icon(Icons.save_alt, size: 20, color: ThemePalette.secondaryDark),
              ],
            ),
            const SizedBox(height: 4),
            Text('Save Number', style: ThemeText.caption)
          ]),
        ),
      ]),
    );
  }
}

class ReceiptButton extends StatelessWidget {
  const ReceiptButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(spacingUnit(1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(AppLink.home);
              },
              style: ThemeButton.btnBig.merge(ThemeButton.outlinedDefault(context)),
              child: Text('GO TO HOME', style: ThemeText.paragraphBold)
            ),
          ),
          SizedBox(width: spacingUnit(1)),
          Expanded(
            child: FilledButton(
              onPressed: () {
                Get.toNamed(AppLink.purchaseHistory);
              },
              style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
              child: Text('HISTORY', style: ThemeText.paragraphBold)
            ),
          ),
        ],
      ),
    );
  }
}