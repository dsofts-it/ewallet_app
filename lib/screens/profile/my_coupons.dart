import 'package:ewallet_app/models/voucher.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/promo/promo_voucher.dart';
import 'package:flutter/material.dart';

class MyCoupons extends StatelessWidget {
  const MyCoupons({super.key});

  @override
  Widget build(BuildContext context) {
    List<Voucher> items = voucherList.sublist(0, 5);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(
          children: [
            Text('You have ${items.length} Coupons', style: ThemeText.caption),
            VSpaceShort(),
            PromoVoucherList(dataList: items),
          ],
        )
      ),
    );
  }
}