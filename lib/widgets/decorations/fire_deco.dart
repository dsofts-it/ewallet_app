import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';

class FireDeco extends StatelessWidget {
  const FireDeco({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 500,
      child: ClipRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 2),
          child: Stack(children: [
            Positioned(
              top: -30,
              left: -30,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(150, 30)),
                  color: ThemePalette.primaryMain
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: -30,
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(200, 60)),
                  color: ThemePalette.tertiaryMain
                ),
              ),
            ),
            Positioned(
              top: -50,
              right: -10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(200, 60)),
                  color: ThemePalette.secondaryMain.withValues(alpha: 0.5)
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}