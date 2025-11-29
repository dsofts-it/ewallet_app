import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/list_item.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

enum HistoryType { all, purchased, wallet, topup, other }

class HeaderFilter extends StatelessWidget {
  const HeaderFilter({
    super.key, this.selectedTitle,
    required this.title, required this.subtitle,
    this.actions, this.withBack = true,
    this.leading
  });

  final HistoryType? selectedTitle;
  final String title;
  final String subtitle;
  final List<Widget>? actions;
  final bool withBack;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return AppBar(
      forceMaterialTransparency: true,
      titleSpacing: 0,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedTitle != null ? _popupMenu(context) : Text(title, style: ThemeText.subtitle),
            ],
          ),
          Text(subtitle, style: ThemeText.caption.copyWith(color: colorScheme(context).onSurface)),
        ],
      ),
      leading: withBack ? BackIconButton(onTap: () {
        Get.back();
      }) : leading,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: TopDecoration(),
      actions: actions ?? [],
      automaticallyImplyLeading: false,
      systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    );
  }

  Widget _popupMenu(BuildContext context) {
    ListItem selectedMenu(HistoryType type) {
      switch(type) {
        case HistoryType.all:
          return ListItem(label: 'All History', value: 'all', icon: Icons.history);
        case HistoryType.purchased:
          return ListItem(label: 'Purchased History', value: 'purchased', icon: Icons.shopping_cart);
        case HistoryType.wallet:
          return ListItem(label: 'Transfer History', value: 'wallet', icon: Icons.wallet);
        case HistoryType.topup:
          return ListItem(label: 'Topup History', value: 'topup', icon: Icons.add_home_rounded);
        default:
          return ListItem(label: 'Other', value: 'other', icon: Icons.list_alt);
      }
    }

    return PopupMenuButton<String>(
      icon: Container(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(1), vertical: 4),
        decoration: BoxDecoration(
          borderRadius: ThemeRadius.xbig,
          color: colorScheme(context).surfaceContainer,
          boxShadow: [ThemeShade.shadeMedium(context)]
        ),
        child: Row(
          children: [
            Icon(selectedMenu(selectedTitle!).icon, size: 18),
            SizedBox(width: 4),
            Text(selectedMenu(selectedTitle!).label, style: ThemeText.paragraphBold,),
            SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded)
          ],
        ),
      ),
      onSelected: (String val) {
        switch(val) {
          case 'purchased':
            Get.toNamed(AppLink.purchaseHistory);
          break;
          case 'wallet':
            Get.toNamed(AppLink.walletHistory);
          break;
          case 'topup':
            Get.toNamed(AppLink.topupHistory);
          break;
          default:
            Get.toNamed(AppLink.history);
          break;
        }
      },
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeRadius.medium,
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.5)),
      ),
      menuPadding: EdgeInsets.all(spacingUnit(1)),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          value: selectedMenu(HistoryType.all).value,
          child: Row(children: [
            Icon(selectedMenu(HistoryType.all).icon,),
            SizedBox(width: 4),
            Text(selectedMenu(HistoryType.all).label,),
          ]),
          onTap: () {},
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          value: selectedMenu(HistoryType.purchased).value,
          child: Row(children: [
            Icon(selectedMenu(HistoryType.purchased).icon),
            SizedBox(width: 4),
            Text(selectedMenu(HistoryType.purchased).label,),
          ]),
          onTap: () {},
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          value: selectedMenu(HistoryType.wallet).value,
          child: Row(children: [
            Icon(selectedMenu(HistoryType.wallet).icon),
            SizedBox(width: 4),
            Text(selectedMenu(HistoryType.wallet).label,),
          ]),
          onTap: () {},
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
          value: selectedMenu(HistoryType.topup).value,
          child: Row(children: [
            Icon(selectedMenu(HistoryType.topup).icon),
            SizedBox(width: 4),
            Text(selectedMenu(HistoryType.topup).label,),
          ]),
          onTap: () {},
        ),
      ],
    );
  }
}