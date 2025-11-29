import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/models/general_list.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';

class MerchantList extends StatefulWidget {
  const MerchantList({super.key});

  @override
  State<MerchantList> createState() => _MerchantListState();
}

class _MerchantListState extends State<MerchantList> {
  final List _banks = <GeneralList>[
    GeneralList(value: 'merchant1', text: 'Merchant A', desc: 'Admin fee: ${userAccount.currencySymbol}1 • minimum topup: ${userAccount.currencySymbol}10', thumb: 'assets/images/logos/logo9.jpg'),
    GeneralList(value: 'merchant2', text: 'Merchant B', desc: 'Free admin fee • minimum topup: ${userAccount.currencySymbol}40', thumb: 'assets/images/logos/logo10.jpg'),
    GeneralList(value: 'merchant3', text: 'Merchant C', desc: 'Admin fee: ${userAccount.currencySymbol}1 • minimum topup: ${userAccount.currencySymbol}10', thumb: 'assets/images/logos/logo11.jpg'),
    GeneralList(value: 'merchant4', text: 'Merchant D', desc: 'Free admin fee • minimum topup: ${userAccount.currencySymbol}50', thumb: 'assets/images/logos/logo12.png'),
    GeneralList(value: 'merchant5', text: 'Merchant E', desc: 'Admin fee: ${userAccount.currencySymbol}1 • minimum topup: ${userAccount.currencySymbol}20', thumb: 'assets/images/logos/logo13.png'),
    GeneralList(value: 'merchant6', text: 'Merchant F', desc: 'Admin fee: ${userAccount.currencySymbol}1 • minimum topup: ${userAccount.currencySymbol}10', thumb: 'assets/images/logos/logo14.jpg'),
  ];

  String _selected = '';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _banks.length,
      itemBuilder: ((BuildContext context, int index){
        final GeneralList item = _banks[index];
        return ListTile(
          title: Row(
            children: [
              Text(item.text!, style: ThemeText.subtitle2),
              item.desc!.toLowerCase().contains('free') ? Container(
                margin: EdgeInsets.only(left: spacingUnit(1)),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: ThemeRadius.big,
                  color: colorScheme(context).secondaryContainer,
                ),
                child: Text('Free', style: ThemeText.caption.copyWith(color: colorScheme(context).onSecondaryContainer),),
              ) : Container()
            ],
          ),
          subtitle: Text(item.desc ?? 'Not Connected', style: ThemeText.caption),
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(item.thumb),
          ),
          trailing: _selected == item.value ?
            Icon(Icons.check_circle, color: ThemePalette.primaryMain)
            : Icon(Icons.circle_outlined, color: colorScheme(context).outline),
          onTap: () {
            setState(() {
              _selected = item.value;
            });
          }
        );
      }),
    );
  }
}