import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/activity_card.dart';
import 'package:ewallet_app/widgets/cards/news_card.dart';
import 'package:ewallet_app/widgets/cards/pricing_card.dart';
import 'package:ewallet_app/widgets/cards/profile_card.dart';
import 'package:ewallet_app/widgets/cards/promo_card.dart';
import 'package:ewallet_app/widgets/cards/reward_card.dart';
import 'package:ewallet_app/widgets/cards/title_icon_card.dart';
import 'package:ewallet_app/widgets/cards/voucher_card.dart';
import 'package:flutter/material.dart';

class CardCollection extends StatelessWidget {
  const CardCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(spacingUnit(2)), children: [
      Text('Activty Card', style: ThemeText.subtitle2),
      const ActivityCard(title: 'Sample Activity', time: 'Yesterday', icon: Icons.history, color: Colors.orange),
      const VSpace(),

      Text('News Card', style: ThemeText.subtitle2),
      Row(
        children: [
          SizedBox(width: 200, child: NewsCard(thumb: ImgApi.photo[1], title: 'News Title', date: '11 Apr 2026')),
        ],
      ),
      const VSpace(),

      Text('Pricing Card', style: ThemeText.subtitle2),
      PricingCard(
        title: 'Best Value',
        price: 200,
        desc: 'Lorem ipsum dolor sit amet',
        features: const <String>['Feature 1', 'Feature 2', 'Feature 3', 'Feature 4', 'Feature 5'],
        enableIcons: const <bool> [true, true, true, false, false],
        bookingLink: AppLink.home,
      ),
      const VSpace(),

      Text('Profile Card', style: ThemeText.subtitle2),
      ProfileCard(avatar: ImgApi.avatar[3], name: 'Jean Doe', distance: 19),
      const VSpace(),

      Text('Promo Card', style: ThemeText.subtitle2),
      PromoCard(thumb: ImgApi.photo[82], point: 20, time: '15 Aug 2025', title: 'Lorem ipsum dolor sit amet'),
      const VSpace(),

      Text('Reward Card', style: ThemeText.subtitle2),
      Row(
        children: [
          SizedBox(height: 250, width: 200, child: RewardCard(image: ImgApi.photo[89], logo: ImgApi.photo[96], title: 'Reward Title', subtitle: 'Fusce et sagittis risus, et condimentum libero.', point: 200)),
        ],
      ),
      const VSpace(),

      Text('Title Icon Card', style: ThemeText.subtitle2),
      const TitleIconCard(icon: Icons.settings, title: 'Title', content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
      )),
      const VSpace(),

      Text('Voucher Card', style: ThemeText.subtitle2),
      SizedBox(height: 80, child: VoucherCard(title: 'Title Voucher', color: Colors.pink, status: VoucherStatus.enable, desc: 'Lorem ipsum dolor sit amet', onSelected: (_) {}, isSelected: false)),
      const VSpaceBig(),
    ]);
  }
}