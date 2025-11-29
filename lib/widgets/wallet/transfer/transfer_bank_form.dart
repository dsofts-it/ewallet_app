import 'package:change_case/change_case.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/models/bank.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_dropdown_search.dart';
import 'package:ewallet_app/widgets/app_input/app_input_box.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:ewallet_app/widgets/wallet/choose_nominal.dart';
import 'package:flutter/material.dart';

class TransferBankForm extends StatefulWidget {
  const TransferBankForm({super.key});

  @override
  State<TransferBankForm> createState() => _TransferBankFormState();
}

class _TransferBankFormState extends State<TransferBankForm> {
  final TextEditingController _textController = TextEditingController();
  final nominals = <double>[10, 20, 50];
  int? _nominal;
  bool _showDoneBtn = false;

  void _setNominal(int val) {
    _textController.text = nominals[val].toStringAsFixed(0);
    setState(() {
      _nominal = val;
    });
  }

  @override
  void initState() {
    super.initState();
    _nominal = 1;
    _textController.text = nominals[_nominal!].toStringAsFixed(0);
  }
  
  @override
  Widget build(BuildContext context) {

    return ListView(shrinkWrap: true, padding: EdgeInsets.all(spacingUnit(2)), children: [
      /// BANK INPUT
      AppDropdownSearch(
        hintText: 'Search or Choose Bank',
        items: bankList,
        label: 'Bank Recipient',
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
      VSpaceShort(),

      /// NOMINAL
      AppInputBox(content: Column(children: [
        /// INPUT NOMINAL
        ChooseNominal(
          selectedIndex: _nominal,
          nominals: nominals,
          onSelected: _setNominal,
        ),
        SizedBox(height: spacingUnit(1)),
        Container(
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
          decoration: BoxDecoration(
            color: colorScheme(context).surface.withValues(alpha: 0.9),
            borderRadius: ThemeRadius.medium,
            border: Border.all(
              width: 1,
              color: colorScheme(context).outline
            )
          ),
          child: TextField(
            textAlign: TextAlign.start,
            controller: _textController,
            keyboardType: TextInputType.number,
            onChanged: (String val) {
              setState(() {
                _nominal = null;
                _showDoneBtn = true;
              });
            },
            decoration: InputDecoration(
              hintText: '10',
              label: Text('Input Amount', textAlign: TextAlign.end, style: ThemeText.headline.copyWith(color: colorScheme(context).onSurfaceVariant)),
              hintStyle: ThemeText.title.copyWith(color: colorScheme(context).onSurfaceVariant),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              prefix: Padding(
                padding: EdgeInsets.symmetric(vertical: spacingUnit(1)),
                child: Text(userAccount.currencySymbol, textAlign: TextAlign.center, style: ThemeText.subtitle),
              ),
              suffix: _showDoneBtn ? TextButton(
                onPressed: () {
                  setState(() {
                    _showDoneBtn = false;
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                child: Text('DONE', style: ThemeText.paragraphBold.copyWith(color: colorScheme(context).onInverseSurface),)
              ) : null
            ),
            style: ThemeText.title.copyWith(color: colorScheme(context).onSurface),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text('Minimum Transfer is ${userAccount.currencySymbol}10', style: ThemeText.caption),
        ),
      ])),
      VSpaceShort(),

      /// DESCRIPTION
      AppTextField(
        label: 'Message (Optional)',
        onChanged: (_) {},
      )

    ]);
  }
}