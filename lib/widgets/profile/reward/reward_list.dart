import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/models/reward.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/widgets/cards/reward_card.dart';

class RewardList extends StatelessWidget {
  const RewardList({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
      padding: EdgeInsets.only(
        top: spacingUnit(2),
        left: spacingUnit(2),
        right: spacingUnit(2),
        bottom: spacingUnit(4),
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 230,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75
      ),
      itemCount: rewardList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = rewardList[index];
        return RewardCard(
          image: item.image,
          logo: item.logo,
          title: item.title,
          subtitle: item.description,
          point: item.points,
        );
      }
    );
  }
}