import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:get/route_manager.dart';

class SearchInputBtn extends StatelessWidget {
  const SearchInputBtn({
    super.key,
    required this.location,
    required this.title,
    this.onCancel,
    this.hasBorder = false,
    this.nextRoute,
  });

  final String location;
  final String title;
  final bool hasBorder;
  final Function()? onCancel;
  final String? nextRoute;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Get.toNamed(location, arguments: {'routeTo': nextRoute} );
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.all(spacingUnit(1)),
        decoration: BoxDecoration(
          boxShadow: [ThemeShade.shadeSoft(context)],
          color: colorScheme(context).surface,
          borderRadius: ThemeRadius.xbig,
          border: hasBorder ? BoxBorder.all(
            width: 1,
            color: colorScheme(context).outlineVariant
          ) : null
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(Icons.search),
          SizedBox(width: spacingUnit(1)),
          Expanded(child: Text(title, style: TextStyle(fontSize: 16, color: colorScheme(context).onSurfaceVariant))),
          onCancel != null ? InkWell(
            onTap: onCancel,
            child: const Icon(Icons.close_outlined)
          ) : Container(),
        ])
      ),
    );
  }
}