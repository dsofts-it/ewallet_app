import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';

class TabMenuSwipe extends StatelessWidget {
  const TabMenuSwipe({ super.key, required this.menus, this.withInput = false, this.tabController, });

  final List<String> menus;
  final bool withInput;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: withInput ? EdgeInsets.all(spacingUnit(2)) : EdgeInsets.zero,
      padding: withInput ? EdgeInsets.all(spacingUnit(1)) : EdgeInsets.zero,
      decoration: withInput ? BoxDecoration(
        color: colorScheme(context).surface,
        borderRadius: ThemeRadius.medium,
      ) : null,
      child: Column(
        children: [
          /// TAB MENU
          Container(
            margin: EdgeInsets.all(spacingUnit(1)),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme(context).surface,
              gradient: ThemePalette.gradientMixedAllLight,
              borderRadius: ThemeRadius.big,
            ),
            child: TabBar(
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.all(4),
              dividerColor: Colors.transparent,
              controller: tabController,
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(60))
              ),
              
              tabs: menus.asMap().entries.map((entry) {
                String item = entry.value;
                return Text(
                  item,
                  style: ThemeText.paragraph.copyWith(fontWeight: FontWeight.bold)
                );
              }).toList()
            ),
          ),

          /// INPUT ID NUMBER
          withInput ? InputIdNumber(
            placeholder: 'Enter your user ID',
            helpText: 'Input your user ID to select a product',
            prefixIcon: Icon(Icons.person),
          ) : Container()
        ],
      ),
    );
  }
}