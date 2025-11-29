import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/account_id.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/profile/profile_action_button.dart';
import 'package:ewallet_app/widgets/profile/profile_detail.dart';
import 'package:ewallet_app/widgets/search/account_list.dart';
import 'package:ewallet_app/widgets/search/contact_list.dart';
import 'package:ewallet_app/widgets/tab_menu/tab_menu_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyFavoritesContact extends StatefulWidget {
  const MyFavoritesContact({super.key});

  @override
  State<MyFavoritesContact> createState() => _MyFavoritesContactState();
}

class _MyFavoritesContactState extends State<MyFavoritesContact>  with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ThemeSize.xs
            ),
            child: TabMenuSwipe(menus: ['Contacts', 'ID Numbers'], tabController: _tabController)
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ContactList(
                items: userList.where((item) => item.isFavorited == true).toList(),
                keyword: '',
                onSelect: (User user) {
                  Get.bottomSheet(
                    Wrap(
                      children: [
                        ProfileDetail(
                          avatar: user.avatar,
                          name: user.name,
                          id: user.phone,
                          bottom: ProfileActionButton(
                            action1Text: 'Request Money',
                            icon1: Icons.file_download_outlined,
                            action2Text: 'Send Money',
                            icon2: Icons.shortcut,
                            onAction1Tap: () {
                              Get.toNamed(AppLink.request);
                            },
                            onAction2Tap: () {
                              Get.toNamed(AppLink.request);
                            },
                          ),
                        ),
                      ],
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent
                  );
                },
              ),
              AccountList(
                items: savedAccountList.where((item) => item.isFavorited == true).toList(),
                keyword: '',
                onSelect: (AccountId account) {
                  Get.bottomSheet(
                    Wrap(
                      children: [
                        ProfileDetail(
                          avatar: getCategory(account.category).image,
                          name: account.name!,
                          id: account.userId,
                          bottom: ProfileActionButton(
                            action1Text: 'Buy Products',
                            icon1: Icons.add_shopping_cart,
                            action2Text: 'Pay Bill',
                            icon2: Icons.receipt_outlined,
                            onAction1Tap: () {
                              Get.toNamed(AppLink.mobilePurchase);
                            },
                            onAction2Tap: () {
                              Get.toNamed(AppLink.mobilePurchase);
                            },
                          ),
                        ),
                      ],
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent
                  );
                },
              )
            ]
          ),
        ),
        VSpaceBig(),
      ],
    );
  }
}