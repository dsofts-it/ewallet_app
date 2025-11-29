import 'package:ewallet_app/models/account_id.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:ewallet_app/widgets/search/account_list.dart';
import 'package:ewallet_app/widgets/search/search_input.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SearchId extends StatefulWidget {
  const SearchId({super.key});

  @override
  State<SearchId> createState() => _SearchIdState();
}

class _SearchIdState extends State<SearchId> {
  final TextEditingController _textRef = TextEditingController();

  bool _showSearchResult = false;
  bool _showFavorite = false;

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
      _showSearchResult = _textRef.text.length >= 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<AccountId> favoritedAccounts =
        savedAccountList.where((account) => account.isFavorited).toList();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: BackIconButton(
          onTap: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
        title: SearchInput(autofocus: true, textRef: _textRef, hintText: 'Search user or number ID',),
        flexibleSpace: TopDecoration(),
        actions: [
          SizedBox(width: spacingUnit(1)),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: colorScheme(context).surface,
              elevation: 3
            ),
            onPressed: () {
              setState(() {
                _showFavorite = false;
              });
            },
            icon: Icon(_showFavorite ? Icons.library_books_outlined : Icons.library_books, color: _showFavorite ? colorScheme(context).onSurface : colorScheme(context).onInverseSurface, size: 20) 
          ),
          SizedBox(width: spacingUnit(1)),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: colorScheme(context).surface,
              elevation: 3
            ),
            onPressed: () {
              setState(() {
                _showFavorite = true;
              });
            },
            icon: Icon(_showFavorite ? Icons.favorite : Icons.favorite_border, color: _showFavorite ? Colors.pink : colorScheme(context).onSurface, size: 20) 
          ),
          SizedBox(width: spacingUnit(1),),
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        VSpaceShort(),
        !_showSearchResult ? Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal:  spacingUnit(2)),
          child: Text(_showFavorite ? 'Favorite Numbers' : 'Latest Transaction Number', style: ThemeText.paragraphBold,)
        ) : Container(),
        Expanded(
          child: _showSearchResult ? AccountList(items: savedAccountList, keyword: _textRef.text)
            : AccountList(
              items: _showFavorite ? favoritedAccounts : savedAccountList.sublist(0, 10),
              keyword: '',
              showAll: true,
            )
        )
      ])
    );
  }
}