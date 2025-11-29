import 'package:ewallet_app/widgets/product/header/product_header_tab.dart';
import 'package:flutter/material.dart';

class PurchaseLayout extends StatelessWidget {
  const PurchaseLayout({
    super.key,
    required this.scaffoldKey,
    required this.name,
    required this.image,
    required this.menus,
    required this.tabController,
    required this.children,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String name;
  final String image;
  final List<String> menus;
  final TabController tabController;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: ProductHeaderTab(
          title: name,
          image: image,
          menus: menus,
          tabController: tabController,
        )
      ),
      body: Column(children: children,)
    );
  }
}