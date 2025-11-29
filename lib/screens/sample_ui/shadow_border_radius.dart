import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:flutter/material.dart';

class ShadowBorderRadius extends StatelessWidget {
  const ShadowBorderRadius({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(spacingUnit(2)), children: [
      Container(
        height: 100,
        padding: EdgeInsets.all(spacingUnit(2)),
        decoration: BoxDecoration(
          color: colorScheme(context).primaryContainer,
          boxShadow: [ThemeShade.shadeSoft(context)],
          borderRadius: ThemeRadius.small,
        ),
        child: const Text('Small Radius - Soft Shadow')
      ),
      const VSpace(),
      Container(
        height: 100,
        padding: EdgeInsets.all(spacingUnit(2)),
        decoration: BoxDecoration(
          color: colorScheme(context).primaryContainer,
          boxShadow: [ThemeShade.shadeMedium(context)],
          borderRadius: ThemeRadius.medium,
        ),
        child: const Text('Medium Radius - Medium Shadow')
      ),
      const VSpace(),
      Container(
        height: 100,
        padding: EdgeInsets.all(spacingUnit(2)),
        decoration: BoxDecoration(
          color: colorScheme(context).primaryContainer,
          boxShadow: [ThemeShade.shadeHard(context)],
          borderRadius: ThemeRadius.big,
        ),
        child: const Text('Large Radius - Hard Shadow')
      ),
    ]);
  }
}