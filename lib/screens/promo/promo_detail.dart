import 'package:change_case/change_case.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/models/promo.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:ewallet_app/widgets/product/package/package_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/promo/promo_desc.dart';

class PromoDetail extends StatefulWidget {
  const PromoDetail({
    super.key,
  });

  @override
  State<PromoDetail> createState() => _PromoDetailState();
}

class _PromoDetailState extends State<PromoDetail> {
  final ScrollController _scrollref = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isFixed = false;

  @override
  void dispose() {
    _scrollref.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Promotion promoItem = promoList[0];
    final bool isDark = Get.isDarkMode;

    _scrollref.addListener(() {
      setState(() {
        if(_scrollref.offset > 100) {
          _isFixed = true;
        } else {
          _isFixed = false;
        }
      });
    });
  
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: BackIconButton(onTap: () {
          Get.back();
        }),
        centerTitle: false,
        titleSpacing: 0,
        flexibleSpace: TopDecoration(),
        /// TITLE
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: _isFixed ? 1 : 0)),
          child: Text(
            promoItem.name.toCapitalCase(),
            overflow: TextOverflow.ellipsis,
            style: ThemeText.subtitle2,
          ),
        ),
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        actions: [
          // POINT
          Container(
            margin: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: ThemeRadius.big
            ),
            child: Text('${promoItem.price} POINT', style: ThemeText.paragraph)
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ThemeSize.sm),
          child: ListView(
            controller: _scrollref,
            children: [
              /// EVENT BANNER HERO AND DESCRIPTON
              PromoDesc(
                title: promoItem.name.toCapitalCase(),
                desc: promoItem.desc,
                thumb: promoItem.thumb,
                terms1: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                terms2: 'Integer sem massa, interdum commodo leo ac, posuere molestie leo',
                terms3: 'Sed iaculis quis lacus sed malesuada. Nam suscipit lacus',
                date: promoItem.date,
                point: promoItem.price,
                liked: true
              ),
          
              /// PACKAGE LIST OF THIS PROMO
              const LineSpace(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
                child: Text(
                  'Explore the best packages!',
                  textAlign: TextAlign.start,
                  style: ThemeText.subtitle.copyWith(fontWeight: FontWeight.bold)
                ),
              ),
              const VSpace(),
              PackageList(
                packageItems: educationPackages,
                scaffoldKey: _scaffoldKey,
                selectable: false,
              ),
              const VSpaceBig()
            ]
          ),
        ),
      )
    );
  }
}
