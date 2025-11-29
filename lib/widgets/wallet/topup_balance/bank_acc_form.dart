import 'package:change_case/change_case.dart';
import 'package:ewallet_app/models/bank.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';

class BankAccForm extends StatefulWidget {
  const BankAccForm({super.key});

  @override
  State<BankAccForm> createState() => _BankAccFormState();
}

class _BankAccFormState extends State<BankAccForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppDropdownSearch(
        hintText: 'Search or Choose Bank',
        items: bankList,
        filled: true,
        listItem: (BuildContext context, dynamic item) => ListTile(
          minTileHeight: 0,
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(item.logo),
            )
          ),
          title: Text(item.name.toString().toCapitalCase(), style: ThemeText.subtitle2,),
        ),
      ),
      SizedBox(height: spacingUnit(2)),
      AppTextField(
        label: 'Account Name',
        onChanged: (_) {},
      ),
      SizedBox(height: spacingUnit(2)),
      AppTextField(
        label: 'Account Number',
        onChanged: (_) {},
      ),
    ]);
  }
}