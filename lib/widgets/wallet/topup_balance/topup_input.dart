import 'dart:ui';

import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';

class TopupInput extends StatefulWidget {
  const TopupInput({super.key, required this.textController, required this.onChanged});

  final TextEditingController textController;
  final Function(String) onChanged;

  @override
  State<TopupInput> createState() => _TopupInputState();
}

class _TopupInputState extends State<TopupInput> {
  bool _showDoneBtn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: ThemeRadius.medium.bottomLeft),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, ThemePalette.primaryMain],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: ThemeRadius.medium.bottomLeft),
        child: Stack(
          children: [
            /// BLUR DECORATIONS
            Positioned(
              top: -120,
              right: -100,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(40, 60)),
                      color: ThemePalette.tertiaryMain.withValues(alpha: 0.4),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(80, 60)),
                      color: ThemePalette.secondaryMain.withValues(alpha: 0.3),
                    ),
                  ),
                ],),
              )
            ),
    
            /// WALLET PROPERTIES
            Column(children: [
              /// BALANCE
              Padding(
                padding: EdgeInsets.symmetric(vertical: spacingUnit(1), horizontal: spacingUnit(2)),
                child: _buildBalanceCard(context),
              ),
              _buildAmountInput(context),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
        padding: EdgeInsets.only(top: spacingUnit(1)),
        child: Row(children: [
          Icon(Icons.account_balance_wallet, color: Colors.white, size: 18),
          SizedBox(width: 4),
          Text('Your Balance:', style: ThemeText.paragraph.copyWith(color: Colors.white, height: 1)),
          SizedBox(width: 4),
          Text(userAccount.currencySymbol, style: ThemeText.paragraph.copyWith(color: Colors.white)),
          Text('123', style: ThemeText.subtitle2.copyWith(color: Colors.white)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text('Minimum Topup: ${userAccount.currencySymbol}10', style: ThemeText.caption.copyWith(color: Colors.white)),
      ),
    ]);
  }

  Widget _buildAmountInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme(context).surface.withValues(alpha: 0.9),
        borderRadius: ThemeRadius.medium,
      ),
      child: TextField(
        textAlign: TextAlign.start,
        controller: widget.textController,
        keyboardType: TextInputType.number,
        onChanged: (String val) {
          widget.onChanged(val);
          setState(() {
            _showDoneBtn = true;
          });
        },
        decoration: InputDecoration(
          hintText: '${userAccount.currencySymbol}100',
          label: Text('Input Nominal Topup', textAlign: TextAlign.end, style: ThemeText.headline.copyWith(color: colorScheme(context).onSurfaceVariant)),
          hintStyle: ThemeText.title.copyWith(color: colorScheme(context).onSurfaceVariant),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          suffix: _showDoneBtn ? TextButton(
            onPressed: () {
              setState(() {
                _showDoneBtn = false;
                FocusManager.instance.primaryFocus?.unfocus();
              });
            },
            style: ThemeButton.btnSmall,
            child: Text('DONE', style: ThemeText.paragraphBold.copyWith(color: colorScheme(context).onInverseSurface),)
          ) : null
        ),
        style: ThemeText.title.copyWith(color: colorScheme(context).onSurface),
      ),
    );
  }
}