import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/shimmer_preloader.dart';
import 'package:ewallet_app/widgets/decorations/dashed_border.dart';
import 'package:ewallet_app/widgets/payment/payment_item.dart';
import 'package:ewallet_app/widgets/product/detail/package_detail.dart';
import 'package:flutter/material.dart';

class ReceiptList extends StatelessWidget {
  const ReceiptList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: () {
          showPackageDetail(context, item: gamePackages[3], withActionBtn: true);
        },
        child: Row(children: [
          ClipRRect(
            borderRadius: ThemeRadius.small,
            child: Image.network(
              ImgApi.photo[122],
              width: 32,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: 32,
                  height: 32,
                  child: ShimmerPreloader()
                );
              },
            ),
          ),
          SizedBox(width: spacingUnit(1)),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('1 x Voucher Space Stickers', maxLines: 1, overflow: TextOverflow.ellipsis, style: ThemeText.paragraphBold),
              Text('john_doe@mail.com', style: ThemeText.caption.copyWith(color: colorScheme(context).onSurfaceVariant)),
            ]),
          ),
          SizedBox(width: spacingUnit(1)),
          Text('${userAccount.currencySymbol}10', style: ThemeText.subtitle2,),
          SizedBox(width: spacingUnit(1)),
          Icon(Icons.arrow_forward_ios, size: 16),
        ]),
      ),
      VSpaceBig(),

      PaymentItem(title: 'Date', value: '22 Jun 2025', indent: false),
      PaymentItem(title: 'Transaction Number:', value: 'A1234567890SSR', indent: false),
      VSpaceShort(),
      PaymentItem(title: 'Subtotal:', boldValue: true, value: '${userAccount.currencySymbol}10', indent: false),
      PaymentItem(title: 'Admin Fee 10%:', boldValue: true, value: '${userAccount.currencySymbol}1', indent: false),
      Padding(
        padding: EdgeInsets.symmetric(vertical: spacingUnit(2)),
        child: DashedBorder(color: colorScheme(context).outlineVariant,),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Total:', style: ThemeText.subtitle),
        Text('${userAccount.currencySymbol}11', style: ThemeText.subtitle),
      ]),
    ]);
  }
}