import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';

class TagHistory extends StatelessWidget {
  const TagHistory({super.key, required this.onTap});

  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final List tagsList = ['Game', 'Mobile', 'Entertainment', 'App', 'Education'];

    return Padding(
      padding: EdgeInsets.all(spacingUnit(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Search History', style: ThemeText.subtitle),
          SizedBox(height: spacingUnit(1)),
          Wrap(alignment: WrapAlignment.start, children: 
            tagsList.map((item) => InkWell(
              onTap: () {
                onTap(item);
              },
              child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: ThemeRadius.big,
                    color: colorScheme(context).primaryContainer,
                  ),
                  child: Text(item),
                ),
            )).toList()
          )
        ],
      ),
    );
  }
}

class TagTrending extends StatelessWidget {
  const TagTrending({super.key, required this.onTap});

  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final List tagsList = ['Open Box', 'Liceria', 'Cineount', 'Course', 'Education', 'Mobile'];

    return Padding(
      padding: EdgeInsets.all(spacingUnit(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending Search', style: ThemeText.subtitle),
          SizedBox(height: spacingUnit(1)),
          Wrap(alignment: WrapAlignment.start, children: 
            tagsList.map((item) => InkWell(
              onTap: () {
                onTap(item);
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: ThemeRadius.big,
                  border: Border.all(color: colorScheme(context).outlineVariant, width: 1),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.trending_up, color: colorScheme(context).onPrimaryContainer),
                  const SizedBox(width: 2),
                  
                  Text(item, style: ThemeText.paragraph)
                ]),
              ),
            )
            ).toList()
          )
        ],
      ),
    );
  }
}