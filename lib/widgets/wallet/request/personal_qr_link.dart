import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/alert_info/alert_info.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:ewallet_app/widgets/tab_menu/tab_menu_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class TabbedBottomSheet extends StatefulWidget {
  const TabbedBottomSheet({super.key, this.currentTab = 0});

  final int currentTab;

  @override
  State<TabbedBottomSheet> createState() => _TabbedBottomSheetState();
}

class _TabbedBottomSheetState extends State<TabbedBottomSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showInputAmount = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: widget.currentTab, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700, // Adjust height as needed
      child: Column(
        children: [
          const GrabberIcon(),
          const VSpaceShort(),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ThemeSize.xs
            ),
            child: TabMenuSwipe(menus: ['QR Code', 'Link'], tabController: _tabController,)
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _qrCode(context),
                _linkId(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _qrCode(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(spacingUnit(2)),
      child: Column(children: [
        Text(userAccount.name, style: ThemeText.subtitle),
        SizedBox(height: spacingUnit(1)),
        Text('(${userAccount.phone})', style: ThemeText.paragraph),
        VSpaceShort(),
        Image.asset('assets/images/dummy/qrcode.jpg', width: 200, fit: BoxFit.fill,),
        Padding(
          padding: EdgeInsets.all(spacingUnit(2)),
          child: Text('QR Expired in 14:23', style: ThemeText.caption),
        ),
        AlertInfo(type: AlertType.info, text: 'Please show this QR Code to receive money'),
        ..._btnArea(context, false),
      ]),
    );
  }

  Widget _linkId(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(spacingUnit(2)),
      child: Column(children: [
        Text('Receive money from anyone', style: ThemeText.subtitle),
        SizedBox(height: spacingUnit(1)),
        Text('Share this link so people can pay you immediately', style: ThemeText.paragraph),
        VSpaceShort(),
        PaperCard(flat: true, colouredBorder: true, content: Padding(
          padding: EdgeInsets.all(spacingUnit(1)),
          child: Text('https://link.ewallet.app/request?full_url=1234567890', style: ThemeText.paragraph, overflow: TextOverflow.ellipsis, maxLines: 1,),
        )),
        ..._btnArea(context, true),
      ]),
    );
  }

  List<Widget> _btnArea(BuildContext context, bool withLink) {
    return <Widget>[
      LineSpace(),
      Row(children: [
        Expanded(child: OutlinedButton(
          onPressed: () {},
          style: ThemeButton.outlinedInvert(context),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Transform.flip(
              flipX: true,
              child: Icon(Icons.reply, size: 18)
            ),
            Text(' Share', style: ThemeText.paragraph)
          ])
        )),
        SizedBox(width: spacingUnit(1)),
        Expanded(child: withLink ? OutlinedButton(
          onPressed: () {},
          style: ThemeButton.outlinedInvert(context),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.link, size: 18),
            Text(' Copy link', style: ThemeText.paragraph)
          ])
        ) : OutlinedButton(
          onPressed: () {},
          style: ThemeButton.outlinedInvert(context),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.burst_mode, size: 18),
            Text(' Save to gallery', style: ThemeText.paragraph)
          ])
        )),
      ]),
      VSpaceShort(),
      _showInputAmount ? Row(
        children: [
          Expanded(
            child: AppTextField(
              prefix: Padding(
                padding: EdgeInsets.symmetric(vertical: spacingUnit(1)),
                child: Text(userAccount.currencySymbol, textAlign: TextAlign.center, style: ThemeText.subtitle),
              ),
              label: 'Input Amount',
              type: TextInputType.number,
              suffix: IconButton(
                onPressed: () {
                  setState(() {
                    _showInputAmount = false;
                  });
                },
                icon: Icon(Icons.close)
              ),
              onChanged: (_) {},
            ),
          ),
        ],
      ) : FilledButton(
        onPressed: () {
          setState(() {
            _showInputAmount = true;
          });
        },
        style: ThemeButton.btnBig.merge(ThemeButton.tonalPrimary(context)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.add, size: 22),
          Text(' Add Amount', style: ThemeText.subtitle2)
        ])
      )
    ];
  }
}

Future<void> showMyQrLink(BuildContext context, int activeTab,) {
  return Get.bottomSheet(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Wrap(children: [
        TabbedBottomSheet(currentTab: activeTab)
      ]);
    }),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: colorScheme(context).surface,
  );
}
