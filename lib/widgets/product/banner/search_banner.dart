import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/check_platforms.dart';
import 'package:ewallet_app/widgets/search/search_input_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/decorations/rounded_deco_main.dart';

class SearchBanner extends SliverPersistentHeaderDelegate {
  const SearchBanner({
    required this.maxExtent,
    required this.minExtent,
    required this.title,
    this.searchTitle,
    required this.background,
    required this.headline,
    required this.desc,
    required this.image,
    this.bgColor
  });

  final String title;
  final String? searchTitle;
  final String headline;
  final String desc;
  final String background;
  final String image;
  final Color? bgColor;

  @override
  final double maxExtent;
  
  @override
  final double minExtent;


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool hideBg = shrinkOffset < 120;
    final bool hideContent = shrinkOffset < 70;
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
          
              /// CURVE DECORATION
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1.2,
                  child: RoundedDecoMain(
                    height: 80,
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
                )
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
                      maxWidth: ThemeSize.sm,
                    ),
                    padding: EdgeInsets.only(
                      left: spacingUnit(2),
                      right: spacingUnit(2),
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
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

              /// SEARCH INPUT
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: maxWidth,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Container(
                      padding: EdgeInsets.all(spacingUnit(1)),
                      constraints: BoxConstraints(
                        maxWidth: ThemeSize.sm,
                      ),
                      child: SearchInputBtn(location: AppLink.searchProduct, hasBorder: true, title: searchTitle ?? 'Search $title')
                    ),
                
                    /// DECORATION
                    Container(
                      width: maxWidth,
                      height: 10,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: colorScheme(context).surfaceContainerLow,
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                          offset: const Offset(0, 2),
                        )],
                      )
                    )
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