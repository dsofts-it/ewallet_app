import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:ewallet_app/widgets/search/contact_list.dart';
import 'package:ewallet_app/widgets/search/search_input.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SearchContact extends StatefulWidget {
  const SearchContact({super.key});

  @override
  State<SearchContact> createState() => _SearchContactState();
}

class _SearchContactState extends State<SearchContact> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textRef = TextEditingController();
  final String? actionRoute = Get.arguments?['routeTo'];

  bool _showSearchResult = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      _showSearchResult = _textRef.text.length >= 3;
    });
  }

  void onContactSelected(User user) {
    if(actionRoute != null) {
      Get.toNamed(actionRoute!);
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<User> favorited = userList.where((user) => user.isFavorited).toList();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: BackIconButton(
          onTap: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(right: spacingUnit(2)),
          child: SearchInput(textRef: _textRef, autofocus: true, hintText: 'Type name or phone number'),
        ),
        flexibleSpace: TopDecoration(),
        bottom: !_showSearchResult ? TabBar(
          controller: _tabController,
          labelStyle: ThemeText.paragraphBold,
          indicatorColor: colorScheme(context).onInverseSurface,
          labelColor: colorScheme(context).onInverseSurface,
          dividerColor: colorScheme(context).primaryContainer,
          tabs: [
            Tab(text: 'Recents'),
            Tab(text: 'All Contacts'),
            Tab(text: 'Favorites',),
          ]
        ) : null,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
        child: _showSearchResult ? ContactList(
          items: userList,
          onSelect: onContactSelected,
          keyword: _textRef.text
          ) : TabBarView(
            controller: _tabController,
            children: [
              ContactList(
                items: userList.sublist(0, 5),
                onSelect: onContactSelected,
                keyword: '',
                showAll: true,
              ),
              ContactList(
                items: userList,
                keyword: '',
                onSelect: onContactSelected,
                showAll: true,
              ),
              ContactList(
                items: favorited,
                keyword: '',
                onSelect: onContactSelected,
                showAll: true,
              ),
            ]
          ),
      )
    );
  }
}