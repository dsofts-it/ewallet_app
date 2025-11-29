import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/widgets/product/billing/billing_detail.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:get/route_manager.dart';

class TopupStatus extends StatelessWidget {
  const TopupStatus({super.key});

  Color statusColor(String status) {
    switch(status) {
      case 'error':
        return Colors.red;
      case 'waiting':
        return Colors.orangeAccent;
      case 'success':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  IconData statusIcon(String status) {
    switch(status) {
      case 'error':
        return Icons.warning;
      case 'waiting':
        return Icons.access_time;
      case 'success':
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor: !isDark ? lighten(ThemePalette.primaryLight, 0.15) : null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(statusIcon('success'), size: 24, color: statusColor('success')),
          SizedBox(width: 4),
          Text('Topup Success', style: ThemeText.subtitle)
        ]),
      ),
      body: Column(children: [
        Expanded(
          /// LIST DETAIL
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ThemeSize.sm
            ),
            child: BillingDetail(
              name: 'Bank ABC Virtual Account',
              withBtn: false,
              lightBg: true,
              icon: CircleAvatar(
                radius: 28,
                backgroundColor: ThemePalette.primaryLight,
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/images/logos/logo3.png', width: 40,),
                ),
              ),
            ) 
          ),
        ),

        /// BUTTON
        Center(
          child: Container(
            padding: EdgeInsets.all(spacingUnit(1)),
            constraints: BoxConstraints(
              maxWidth: ThemeSize.sm
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed(AppLink.home);
                    },
                    style: ThemeButton.btnBig.merge(ThemeButton.outlinedDefault(context)),
                    child: Text('GO TO HOME', style: ThemeText.paragraphBold)
                  ),
                ),
                SizedBox(width: spacingUnit(1)),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Get.toNamed(AppLink.topupHistory);
                    },
                    style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                    child: Text('HISTORY', style: ThemeText.paragraphBold)
                  ),
                ),
              ],
            ),
          ),
        ),
        const VSpace()
      ])
    );
  }
}
