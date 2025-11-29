import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';

class BalanceStats extends StatelessWidget {
  const BalanceStats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 15.0,
              backgroundColor: ThemePalette.secondaryMain.withValues(alpha: 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(ThemePalette.secondaryMain),
            ),
          ),
          Text('70%', style: ThemeText.subtitle)
        ],
      )
    );
  }
}