import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/check_platforms.dart';
import 'package:ewallet_app/widgets/action_header/product_action_btn.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/product/banner/tab_banner_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class PurchaseCoverLayout extends StatelessWidget {
  const PurchaseCoverLayout({
    super.key,
    required this.scaffoldKey,
    required this.name,
    required this.headline,
    required this.desc,
    required this.icon,
    required this.menus,
    required this.tabController,
    required this.children,
    required this.background,
    required this.color,
    this.scrollController,
    this.extendBottom
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String name;
  final String headline;
  final String desc;
  final String background;
  final String icon;
  final Color color;
  final List<String> menus;
  final TabController tabController;
  final List<Widget> children;
  final ScrollController? scrollController;
  final Widget? extendBottom;

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: BackIconButton(
          invert: true,
          onTap: () {
            Get.back();
          },
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
        actions: productActionBtn(invert: true),
      ),
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverPersistentHeader(
            delegate: TabBannerCover(
              minExtent: topPadding + 240,
              maxExtent: isOnDesktopAndWeb() ? 380 : 420,
              title: name,
              headline: headline,
              desc: desc,
              image: icon,
              background: background,
              bgColor: color,
              menus: menus,
              tabController: tabController,
              bottom: extendBottom
            ),
            pinned: true,
          ),
        ],
        body: Column(children: children,)
      )
    );
  }
}