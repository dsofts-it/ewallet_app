import 'package:change_case/change_case.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_dropdown_search.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';

class SplitBillForm extends StatefulWidget {
  const SplitBillForm({super.key});

  @override
  State<SplitBillForm> createState() => _SplitBillFormState();
}

class _SplitBillFormState extends State<SplitBillForm> {
  bool _showDoneBtn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(spacingUnit(2)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(spacingUnit(1)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Total Billing:', style: ThemeText.title2,),
              Text('${userAccount.currencySymbol}114', style: ThemeText.title2.copyWith(color: ThemePalette.tertiaryMain),),
            ]),
          ),
          VSpaceShort(),
      
          /// RECEIPIENT INPUT
          AppDropdownSearch(
            hintText: 'Search or Choose Contact',
            items: userList,
            label: 'Contact',
            filled: true,
            listItem: (BuildContext context, dynamic item) => ListTile(
              minTileHeight: 0,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              leading: AvatarNetwork(
                radius: 16,
                backgroundColor: Colors.grey[100],
                backgroundImage: item.avatar,
              ),
              title: Text(item.name.toString().toCapitalCase(), style: ThemeText.subtitle2,),
              subtitle: Text(item.phone, style: ThemeText.paragraph,),
            ),
          ),
          VSpaceShort(),
      
          AppTextField(
            prefix: Padding(
              padding: EdgeInsets.symmetric(vertical: spacingUnit(1)),
              child: Text(userAccount.currencySymbol, textAlign: TextAlign.center, style: ThemeText.subtitle),
            ),
            label: 'Input Amount',
            type: TextInputType.number,
            onChanged: (String val) {
              setState(() {
                _showDoneBtn = true;
              });
            },
            suffix: _showDoneBtn ? TextButton(
              onPressed: () {
                setState(() {
                  _showDoneBtn = false;
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              },
              child: Text('DONE', style: ThemeText.paragraphBold.copyWith(color: colorScheme(context).onInverseSurface),)
            ) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text('Billing left: ${userAccount.currencySymbol}12', style: ThemeText.paragraphBold.copyWith(color: Colors.amber)),
          ),
          VSpaceShort(),
      
          /// DESCRIPTION
          AppTextField(
            label: 'Message (Optional)',
            onChanged: (_) {},
          ),
          VSpaceShort(),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: ThemeButton.outlinedInvert(context),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.add),
                  Text(' Add Bill', style: ThemeText.paragraphBold,)
                ])
              ),
            ],
          ),
        ]
      ),
    );
  }
}