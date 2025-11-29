import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/check_platforms.dart';
import 'package:ewallet_app/widgets/action_header/product_action_btn.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/product/banner/search_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class ProductLayout extends StatelessWidget {
  const ProductLayout({
    super.key,
    required this.title,
    required this.headline,
    required this.searchTitle,
    required this.desc,
    required this.icon,
    required this.background,
    required this.color,
    required this.children
  });

  final String title;
  final String headline;
  final String searchTitle;
  final String desc;
  final String icon;
  final String background;
  final Color color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
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
      body: CustomScrollView(
        slivers: <Widget>[
          /// SLIVER APPBAR AND BANNER
          SliverPersistentHeader(
            delegate: SearchBanner(
              minExtent: topPadding + 130,
              maxExtent: isOnDesktopAndWeb() ? 260 : 320,
              title: title,
              headline: headline,
              searchTitle: searchTitle,
              desc: desc,
              image: icon,
              background: background,
              bgColor: color
            ),
            pinned: true,
          ),

          /// CONTENT
          SliverToBoxAdapter(
            child: Column(children: children)
          )
        ]
      ),
    );
  }
}