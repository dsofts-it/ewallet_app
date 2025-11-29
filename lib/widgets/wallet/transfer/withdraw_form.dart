import 'package:change_case/change_case.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/bank.dart';
import 'package:ewallet_app/models/vendor.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/shimmer_preloader.dart';
import 'package:ewallet_app/widgets/app_input/app_dropdown_search.dart';
import 'package:ewallet_app/widgets/app_input/app_input_box.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:flutter/material.dart';

class WithdrawForm extends StatefulWidget {
  const WithdrawForm({super.key, required this.selectedTarget, required this.setSelectedTarget});

  final String selectedTarget;
  final Function(String) setSelectedTarget;

  @override
  State<WithdrawForm> createState() => _WithdrawFormState();
}

class _WithdrawFormState extends State<WithdrawForm> {
  final TextEditingController _textController = TextEditingController();
  bool _allIn = false;
  bool _showDoneBtn = false;

  @override
  Widget build(BuildContext context) {
    double balance = 123;

    return ListView(shrinkWrap: true, padding: EdgeInsets.all(spacingUnit(2)), children: [
      /// BALANCE INFO
      Container(
        padding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
        decoration: BoxDecoration(
          borderRadius: ThemeRadius.medium,
          border: Border.all(
            width: 1,
            color: ThemePalette.primaryMain,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(spacingUnit(1)),
          leading: Image.asset(branding.logo, width: 48),
          title: RichText(
            text: TextSpan(
              style: ThemeText.subtitle2.copyWith(color: colorScheme(context).onSurface),
              children: [
                TextSpan(
                  text: 'Your Balance: ',
                  style: ThemeText.subtitle,
                ),
                TextSpan(
                  text: '${userAccount.currencySymbol}$balance',
                  style: ThemeText.title2.copyWith(color: colorScheme(context).onPrimaryContainer),
                ),
              ],
            ),
          ),
        )
      ),
      VSpaceShort(),

      /// INPUT AMOUNT
      AppInputBox(filled: true, content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(
          textAlign: TextAlign.start,
          controller: _textController,
          keyboardType: TextInputType.number,
          onChanged: (String val) {
            setState(() {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text('Minimum Withdrawal: ${userAccount.currencySymbol}100', style: ThemeText.caption),
        ),
      ])),
      VSpaceShort(),
      Row(children: [
        Icon(Icons.wallet, size: 18,),
        SizedBox(width: 4),
        Expanded(child: Text('Withdraw all balances', style: ThemeText.paragraph,)),
        SizedBox(
          height: 32,
          child: FittedBox(
            child: Switch(
              value: _allIn,
              onChanged: (bool newValue) {
                setState(() {
                  _allIn = newValue;
                  if (newValue) {
                    _textController.text = balance.toString();
                  } else {
                    _textController.text = '';
                  }
                });
              },
            ),
          ),
        ),
      ]),
      VSpaceBig(),

      /// WITHDRAW METHOD
      Text('Choose Withdraw Method:', textAlign: TextAlign.start, style: ThemeText.subtitle2),
      SizedBox(height: spacingUnit(1)),
      Row(children: [
        Expanded(child: _methodOption(context, ImgApi.iconGrdAtm, 'Via ATM', widget.selectedTarget == 'atm', () {
          widget.setSelectedTarget('atm');
        })),
        SizedBox(width: spacingUnit(1)),
        Expanded(child: _methodOption(context, ImgApi.iconGrdMerchant, 'Via Merchant', widget.selectedTarget == 'merchant', () {
          widget.setSelectedTarget('merchant');
        })),
      ]),
      VSpaceBig(),

      /// BANK AND MERCHANT
      widget.selectedTarget == 'atm' ? AppDropdownSearch(
        hintText: 'Search or Choose ATM Bank',
        items: bankList,
        label: 'Bank Receiver',
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
      ) : Container(),
      
      widget.selectedTarget == 'merchant' ? AppDropdownSearch(
        hintText: 'Search or Choose Merchant',
        items: vendorList.sublist(20, 30),
        label: 'Merchant',
        filled: true,
        listItem: (BuildContext context, dynamic item) => ListTile(
          minTileHeight: 0,
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.network(
                item.logo,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 32,
                    height: 32,
                    child: ShimmerPreloader()
                  );
                },
              ),
            )
          ),
          title: Text(item.name.toString().toCapitalCase(), style: ThemeText.subtitle2,),
        ),
      ) : Container(),
      VSpaceShort(),
    ]);
  }

  Widget _methodOption(BuildContext context, String icon, String name, bool isSelected, Function() ontap) {
    return PaperCard(
      flat: true,
      coloured: isSelected,
      content: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
        leading: Image.asset(icon, width: 32,),
        title: Text(name, style: ThemeText.paragraphBold.copyWith(color: isSelected ? Colors.white : colorScheme(context).onSurface),),
        onTap: ontap,
      )
    );
  }
}