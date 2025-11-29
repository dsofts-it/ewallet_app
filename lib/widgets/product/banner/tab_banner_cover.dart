import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/check_platforms.dart';
import 'package:ewallet_app/widgets/tab_menu/tab_menu_swipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/decorations/rounded_deco_main.dart';

class TabBannerCover extends SliverPersistentHeaderDelegate {
  const TabBannerCover({
    required this.maxExtent,
    required this.minExtent,
    required this.title,
    required this.background,
    required this.headline,
    required this.desc,
    required this.image,
    this.bgColor,
    required this.menus,
    this.tabController,
    this.bottom
  });

  final String title;
  final String headline;
  final String desc;
  final String background;
  final String image;
  final Color? bgColor;
  final List<String> menus;
  final TabController? tabController;
  final Widget? bottom;

  @override
  final double maxExtent;
  
  @override
  final double minExtent;


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool hideBg = shrinkOffset < 120;
    final bool hideContent = shrinkOffset < 30;
    final Color color = bgColor ?? colorScheme(context).outline;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraint) {
        double maxWidth = constraint.maxWidth;
        
        return Container(
          padding: EdgeInsets.only(top: isOnDesktopAndWeb() ? 0 : 40),
          decoration: BoxDecoration(
            color: bgColor ?? colorScheme(context).outline,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[color, darken(color, 0.4)]
            )
          ),
          width: maxWidth,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              /// BACKGROUND
              AnimatedOpacity(
                opacity: hideBg ? 0.25 : 0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Image.asset(
                    background,
                    key: ValueKey<String>(background),
                    width: maxWidth,
                    height: maxExtent,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          
              /// TITLE
              Positioned(
                top: isOnIos() ? 24 : 8,
                child: AnimatedOpacity(
                  opacity: hideBg ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: Text(title, style: ThemeText.subtitle.copyWith(color: Colors.white)),
                ),
              ),

              /// BANNER CONTENT
              AnimatedOpacity(
                opacity: hideContent ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: ThemeSize.sm
                    ),
                    padding: EdgeInsets.only(
                      left: spacingUnit(2),
                      right: spacingUnit(2),
                      top: spacingUnit(10)
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(headline, style: ThemeText.title2.copyWith(color: Colors.white)),
                            Text(desc, style: ThemeText.paragraph.copyWith(color: Colors.white),)
                          ],
                        ),
                      ),
                      SizedBox(width: spacingUnit(1),),
                      Image.asset(
                        image,
                        width: 100,
                        fit: BoxFit.contain,
                      )
                    ]),
                  ),
                ),
              ),

              /// TAB MENU
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: maxWidth,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: ThemeSize.sm,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ThemeSize.sm
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                /// CURVE DECORATION
                                Positioned(
                                  bottom: 0,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: RoundedDecoMain(
                                      height: 70,
                                      baseHeight: 20,
                                      bgDecoration: BoxDecoration(
                                        color: colorScheme(context).surfaceContainerLow,
                                        boxShadow: [BoxShadow(
                                          color: colorScheme(context).surfaceContainerLowest,
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                          offset: const Offset(0, 2),
                                        )],
                                      ),
                                    ),
                                  ),
                                ),
                                TabMenuSwipe(menus: menus, tabController: tabController),
                              ],
                            ),
                            Container(
                              color: colorScheme(context).surfaceContainerLow,
                              child: bottom ?? Container()
                            )
                          ],
                        )
                      ),
                    ),
                  ]),
                ),
              ),
            ]
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => OverScrollHeaderStretchConfiguration();
}