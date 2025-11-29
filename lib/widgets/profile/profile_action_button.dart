import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  const ProfileActionButton({
    super.key,
    required this.action1Text, this.action2Text,
    this.onAction1Tap, this.onAction2Tap,
    required this.icon1, this.icon2
  });

  final String action1Text;
  final String? action2Text;
  final Function()? onAction1Tap;
  final Function()? onAction2Tap;
  final IconData icon1;
  final IconData? icon2;

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
              onPressed: onAction1Tap,
              style: ThemeButton.btnBig.merge(ThemeButton.outlinedDefault(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon1),
                  SizedBox(width: 4),
                  Text(action1Text, style: ThemeText.paragraphBold),
                ],
              )
            ),
          ),
          action2Text != null ? Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: spacingUnit(1)),
              child: OutlinedButton(
                onPressed: onAction2Tap,
                style: ThemeButton.btnBig.merge(ThemeButton.outlinedDefault(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon2),
                    SizedBox(width: 4),
                    Text(action2Text!, style: ThemeText.paragraphBold),
                  ],
                )
              ),
            ),
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class ProfileOptions extends StatefulWidget {
  const ProfileOptions({super.key});

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  bool _isLike = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(spacingUnit(1)),
      constraints: BoxConstraints(
        maxWidth: ThemeSize.sm
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isLike = !_isLike;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                  children: [
                  CircleAvatar(
                    backgroundColor: ThemePalette.tertiaryLight,
                    radius: 22,
                  ),
                  Icon(_isLike ? Icons.favorite : Icons.favorite_border, size: 32, color: ThemePalette.tertiaryDark),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(_isLike ? 'Favorited' : 'Add to Favorite', style: ThemeText.caption)
          ]),
        ),
        Expanded(
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: ThemePalette.primaryLight,
                        radius: 22,
                      ),
                      Transform.flip(
                        flipX: true,
                        child: Icon(Icons.reply, size: 32, color: ThemePalette.primaryDark)
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Share', style: ThemeText.caption)
                ]),
              ),
            ],
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              confirmDialog(
                context,
                title: 'Info',
                content: Text('Number has been copied'),
                confirmAction: () {
                  Navigator.of(context).pop();
                },
                cancelText: 'Close'
              );
            },
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: ThemePalette.secondaryLight,
                    radius: 22,
                  ),
                  Icon(Icons.copy, size: 32, color: ThemePalette.secondaryDark),
                ],
              ),
              const SizedBox(height: 4),
              Text('Copy Number', style: ThemeText.caption)
            ]),
          ),
        ),
      ]),
    );
  }
}
