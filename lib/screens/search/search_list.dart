import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:ewallet_app/widgets/search/autocomplete_list.dart';
import 'package:ewallet_app/widgets/search/search_input.dart';
import 'package:ewallet_app/widgets/search/search_tags.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
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
      _showList = _textRef.text.length >= 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: BackIconButton(onTap: () {
          Get.back();
        }),
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(right: spacingUnit(2)),
          child: SearchInput(autofocus: true, textRef: _textRef, hintText: 'Search Packages, Services or Vouchers',),
        ),
        flexibleSpace: TopDecoration(),
      ),
      body: _showList ? AutocompleteList(keyword: _textRef.text) : ListView(children: [
        VSpaceShort(),
        TagHistory(onTap: (String val) {
          _textRef.text = val;
        }),
        VSpaceShort(),
        TagTrending(onTap: (String val) {
          _textRef.text = val;
        })
      ])
    );
  }
}