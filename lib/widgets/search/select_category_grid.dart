import 'package:change_case/change_case.dart';
import 'package:ewallet_app/models/product.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';

class SelectCategoryGrid extends StatelessWidget {
  const SelectCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;
    final bool wideScreen = ThemeBreakpoints.smUp(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
        child: Text('Category Search', style: ThemeText.subtitle),
      ),
      GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(spacingUnit(2)),
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: wideScreen ? 4 : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 4,
        ),
        itemBuilder: (context, index) {
          Product item = productList[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(item.route ?? '/');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: ThemeRadius.medium,
                color: !isDark ? item.color.withValues(alpha: 0.25) : null,
                gradient: isDark ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                  colors: [
                    Colors.transparent,
                    item.color
                  ],
                ) : null,
              ),
              child: Padding(
                padding: EdgeInsets.all(spacingUnit(1)),
                child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Expanded(child: Text(item.name.toCapitalCase(), style: TextStyle(fontWeight: FontWeight.bold, color: item.color))),
                  Image.asset(item.icon, fit: BoxFit.contain, height: 30,)
                ]),
              ),          
            ),
          );
        },
      )
    ]);
  }
}