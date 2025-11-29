import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:flutter/material.dart';

class ChooseNominal extends StatelessWidget {
  const ChooseNominal({super.key, required this.onSelected, this.selectedIndex, required this.nominals});

  final Function(int) onSelected;
  final int? selectedIndex;
  final List<double> nominals;

  @override
  Widget build(BuildContext context) {
    final bool wideScreen = ThemeBreakpoints.smUp(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Choose Nominal:', textAlign: TextAlign.start, style: ThemeText.subtitle2),
      SizedBox(height: spacingUnit(1)),
      GridView.builder(
        shrinkWrap: true,
        itemCount: nominals.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: wideScreen ? 200 : 150,
          mainAxisExtent: 35,
          childAspectRatio: 0.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8
        ),
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          
          return InkWell(
            borderRadius: ThemeRadius.medium,
            onTap: () {
              onSelected(index);
            },
            child: PaperCard(
              flat: true,
              coloured: isSelected,
              content: Padding(
                padding: EdgeInsets.all(4),
                child: Center(
                  child: RichText(
                    text: TextSpan(text: userAccount.currencySymbol, style: ThemeText.paragraph.copyWith(fontFamily: appFont, color: isSelected ? Colors.white : colorScheme(context).onSurface), children: [
                      TextSpan(text: nominals[index].toStringAsFixed(0), style: ThemeText.subtitle2.copyWith(fontFamily: appFont, color: isSelected ? Colors.white : colorScheme(context).onSurface),)
                    ])
                  )
                ),
              )
            ),
          );
        },
      )
    ]);
  }
}