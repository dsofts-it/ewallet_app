import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/search/contact_list.dart';
import 'package:ewallet_app/widgets/tab_menu/tab_menu_swipe.dart';
import 'package:ewallet_app/widgets/wallet/transfer/transfer_menu.dart';
import 'package:ewallet_app/widgets/wallet/recent_transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    /// TAB CONTROLLER
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    final List<User> favorited = userList.where((user) => user.isFavorited).toList();
    
    return Column(children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.xs
        ),
        child: TabMenuSwipe(menus: ['All Transfer', 'Favorites'], tabController: _tabController,))
      ,
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            /// ALL TRANSFERS
            ListView(padding: EdgeInsets.all(spacingUnit(1)), shrinkWrap: true, children: [
              TransferMenu(),
              VSpaceBig(),
              RecentTransactions(),
              VSpaceBig(),
            ]),
            ContactList(
              items: favorited,
              keyword: '',
              onSelect: (_) { Get.toNamed(AppLink.transferPersonal); },
              showAll: true,
            ),
          ]
        ),
      )
    ]);
  }
}