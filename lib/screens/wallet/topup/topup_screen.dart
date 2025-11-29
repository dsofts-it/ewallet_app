import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/topup_options.dart';
import 'package:ewallet_app/widgets/wallet/choose_nominal.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/topup_input.dart';
import 'package:get/route_manager.dart';

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  final TextEditingController _textController = TextEditingController();
  final nominals = <double>[10, 20, 50, 100, 200, 500];
  String _topupMethod = '';
  int? _nominal;

  void _setTopupMethod(String val) {
    setState(() {
      _topupMethod = val;
    });
  }

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
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// INPUT
            Padding(
              padding: EdgeInsets.all(spacingUnit(2)),
              child: TopupInput(
                textController: _textController,
                onChanged: (String val) {
                  setState(() {
                    _nominal = null;
                  });
                },
              ),
            ),
        
            /// OPTIONS
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
                    child: ChooseNominal(
                      selectedIndex: _nominal,
                      nominals: nominals,
                      onSelected: _setNominal,
                    ),
                  ),
                  VSpace(),
                  TopupOptions(topupMethod: _topupMethod, setTopupMethod: _setTopupMethod),
                ],
              )
            ),
        
            /// BUTTON
            Container(
              padding: EdgeInsets.only(
                top: spacingUnit(2),
                bottom: spacingUnit(5),
                left: spacingUnit(2),
                right: spacingUnit(2)
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _topupMethod.isNotEmpty ? () {
                    confirmDialog(
                      context,
                      title: 'Confirm',
                      content: _dialogConfirm(context),
                      confirmAction: () {
                        Get.toNamed('/topup/$_topupMethod');
                      }
                    );
                  } : null,
                  style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                  child: Text('CONTINUE', style: ThemeText.subtitle2)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dialogConfirm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(spacingUnit(2)),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(bottom: spacingUnit(1)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Nominal:', style: ThemeText.paragraph,),
            Text('${userAccount.currencySymbol}100', style: ThemeText.paragraphBold,),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: spacingUnit(1)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Admin fee:', style: ThemeText.paragraph,),
            Text('${userAccount.currencySymbol}1', style: ThemeText.paragraphBold,),
          ]),
        ),
        Divider(color: colorScheme(context).outline),
        Padding(
          padding: EdgeInsets.only(bottom: spacingUnit(1)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Total:', style: ThemeText.subtitle2),
            Text('${userAccount.currencySymbol}101', style: ThemeText.subtitle2),
          ]),
        ),
      ]),
    );
  }
}