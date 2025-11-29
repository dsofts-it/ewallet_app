import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/shimmer_preloader.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/decorations/rounded_deco_main.dart';
import 'package:ewallet_app/widgets/product/detail/vendor_detail.dart';
import 'package:ewallet_app/widgets/tab_menu/tab_menu_swipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class ProductHeaderTab extends StatefulWidget {
  const ProductHeaderTab({
    super.key,
    required this.title,
    required this.image,
    required this.menus,
    this.tabController
  });

  final String title;
  final String image;
  final List<String> menus;
  final TabController? tabController;

  @override
  State<ProductHeaderTab> createState() => _ProductHeaderTabState();
}

class _ProductHeaderTabState extends State<ProductHeaderTab> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      forceMaterialTransparency: true,
      titleSpacing: 0,
      actionsPadding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
      leading: BackIconButton(
        invert: true,
        onTap: () {
          Get.back();
        },
      ),
      title: Text(widget.title, style: ThemeText.subtitle.copyWith(color: Colors.white)),
      systemOverlayStyle: SystemUiOverlayStyle.light,

      /// BACKGROUND
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.image,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: double.infinity,
                height: 120,
                child: ShimmerPreloader()
              );
            },
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 1),
                    Colors.black.withValues(alpha: 0.75),
                    Colors.black.withValues(alpha: 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
              ),
            ) 
          )
        ]
      ),

      /// ACTION BUTTON
      actions: <Widget>[
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            iconSize: 16,
            onPressed: () {
              setState(() {
                _liked = !_liked;
              });
            },
            style: IconButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: Colors.white
              )
            ),
            icon: Icon(_liked ? Icons.favorite : Icons.favorite_outline, color: _liked ? Colors.pink : Colors.white)
          ),
        ),
        SizedBox(width: spacingUnit(1)),
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            iconSize: 16,
            onPressed: () {
              showVendorDetail(context);
            },
            style: IconButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: Colors.white
              )
            ),
            icon: Icon(Icons.info, color: Colors.white)
          ),
        ),
      ],

      /// TAB WITH DECORATION
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1.2,
            child: RoundedDecoMain(
              height: 50,
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
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ThemeSize.sm
            ),
            child: TabMenuSwipe(menus: widget.menus, tabController: widget.tabController)
          ),
        ])
      )
    );
  }
}