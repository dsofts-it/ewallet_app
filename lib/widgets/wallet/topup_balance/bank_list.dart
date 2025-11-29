import 'package:ewallet_app/models/bank.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';

class BankList extends StatefulWidget {
  const BankList({super.key});

  @override
  State<BankList> createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  Bank? _selected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: true,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.all(spacingUnit(2)),
      itemCount: bankList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ThemeBreakpoints.smUp(context) ? 4 : 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        Bank item = bankList[index];
        return InkWell(
          onTap: () {
            setState(() {
              _selected = item;
            });
          },
          child: Container(
            padding: EdgeInsets.all(spacingUnit(1)),
            decoration: BoxDecoration(
              borderRadius: ThemeRadius.small,
              border: Border.all(
                width: 2,
                color: _selected == item ? ThemePalette.primaryMain : colorScheme(context).outline
              )
            ),
            child: Image.asset(item.logo, fit: BoxFit.fitWidth,),
          ),
        );
      }
    );
  }
}