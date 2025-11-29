import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:ewallet_app/widgets/product/package/package_list_slider.dart';
import 'package:ewallet_app/widgets/product/topup/topup_list_slider.dart';
import 'package:ewallet_app/widgets/search/search_input.dart';
import 'package:ewallet_app/widgets/search/search_result_product.dart';
import 'package:ewallet_app/widgets/search/search_tags.dart';
import 'package:ewallet_app/widgets/search/select_category_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final TextEditingController _textRef = TextEditingController();

  bool _showList = false;

  @override
  void initState() {
    super.initState();
    _textRef.addListener(_checkTextLength);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textRef.dispose();
    super.dispose();
  }

  void _checkTextLength() {
    setState(() {
      _showList = _textRef.text.length > 2;
    });
  }

  void _showResult(String keyword) {
    setState(() {
      _showList = true;
      _textRef.text = keyword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Package> packageList = [
      mobilePackages[0],
      mobilePackages[4],
      mobilePackages[7],
      mobilePackages[11],
      mobilePackages[14],
      mobilePackages[18],
      mobilePackages[3],
      mobilePackages[17],
      mobilePackages[1],
      mobilePackages[6],
    ];

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: BackIconButton(onTap: () {
          Get.back();
        }),
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(right: spacingUnit(2)),
          child: SearchInput(autofocus: true, textRef: _textRef, hintText: 'Search game, mobile, or apps',),
        ),
        flexibleSpace: TopDecoration(),
      ),
      body: _showList ? SearchResultProduct(keyword: _textRef.text) : ListView(children: [
        /// SUGGESTION
        VSpaceShort(),
        TagHistory(onTap: (String item) { _showResult(item); },),
        TagTrending(onTap: (String item) { _showResult(item); },),
        VSpaceShort(),
        SelectCategoryGrid(),
        VSpace(),

        /// RECOMMENDED PROMO
        PackageListSlider(
          title: 'Recomended Mobile Package',
          packageList: packageList,
          withCover: false,
        ),
        VSpace(),
        TopupListSlider(
          title: 'Recomended Credit Topup',
          creditList: educationCredits,
          category: 'education',
          creditType: CreditType.coin,
        ),
        VSpaceBig()
      ])
    );
  }
}