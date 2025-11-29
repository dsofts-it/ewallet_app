import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';

class RequestReview extends StatelessWidget {
  const RequestReview({super.key});

  @override
  Widget build(BuildContext context) {
    final User item = userList[0];
    
    return Column(children: [
      VSpaceShort(),
      Container(
        decoration: BoxDecoration(
          borderRadius: ThemeRadius.medium,
          color: colorScheme(context).primaryContainer.withValues(alpha: 0.25)
        ),
        padding: EdgeInsets.all(spacingUnit(1)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Amount', style: ThemeText.subtitle),
          Text('${userAccount.currencySymbol}123', style: ThemeText.subtitle),
        ]),
      ),
      Container(
        width: 360,
        padding: EdgeInsets.all(spacingUnit(1)),
        child: Column(
          children: [
            ListTile(
              leading: AvatarNetwork(
                radius: 24,
                backgroundImage: item.avatar,
              ),
              title: Text('Request to: ${item.name}', style: ThemeText.paragraphBold),
              subtitle: Text(item.phone, style: ThemeText.caption),
            )
          ],
        ),
      ),
    ]);
  }
}