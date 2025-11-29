import 'package:change_case/change_case.dart';
import 'package:ewallet_app/controller/history_filter_controller.dart';
import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/transaction.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/widgets/title/title_basic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryFilter extends StatelessWidget {
  HistoryFilter({ super.key });

  final HistoryFilterController controller = Get.put(HistoryFilterController());

  @override
  Widget build(BuildContext context) {
    List<String> sortList = ['date', 'price', 'status', 'category'];
    return ListView(shrinkWrap: true, children: [
      /// SORTER
      Row(
        children: [
          Icon(Icons.sort),
          Text(' Sort by:', style: ThemeText.subtitle2),
        ],
      ),
      SizedBox(height: spacingUnit(1)),
      Obx(() => RadioGroup<String>(
        groupValue: controller.sortby.value,
        onChanged: (String? value) {
          controller.onUpdateSortBy(value);
        },
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: sortList.length,
          itemBuilder: (context, index) {
            final item = sortList[index];
            return RadioListTile<String>(
              title: Text(item.toCapitalCase()),
              value: item,
            );
          },
        ),
      )),
      VSpace(),

      /// STATUS
      Row(
        children: [
          Icon(Icons.info_outline),
          Text(' Status:', style: ThemeText.subtitle2),
        ],
      ),
      SizedBox(height: spacingUnit(1)),
      Obx(() => Wrap(
        alignment: WrapAlignment.start,
        spacing: spacingUnit(1),
        children: [
          _tagButton(
            context,
            'Success',
            () { controller.onUpdateStatus(TransactionStatus.success); },
            controller.status.contains(TransactionStatus.success),
            Colors.green,
          ),
          _tagButton(
            context,
            'Pending',
            () { controller.onUpdateStatus(TransactionStatus.pending); },
            controller.status.contains(TransactionStatus.pending),
            Colors.amber,
          ),
          _tagButton(
            context,
            'Failed',
            () { controller.onUpdateStatus(TransactionStatus.failed); },
            controller.status.contains(TransactionStatus.failed),
            Colors.red,
          ),
        ],
      )),
      const VSpaceBig(),

      /// CATEGORY
      Row(
        children: [
          Icon(Icons.grid_view),
          Text(' Category:', style: ThemeText.subtitle2),
        ],
      ),
      SizedBox(height: spacingUnit(2)),
      ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final CategoryType item = categoryList[index];
      
          return Obx(() => CheckboxListTile(
            secondary: CircleAvatar(
              radius: 15,
              backgroundColor: item.color.withValues(alpha: 0.5),
              child: Image.asset(item.image, height: 24),
            ),
            title: Text(item.name.toCapitalCase()),
            value: controller.categories.contains(item),
            onChanged: (bool? value) {
              if (value == true) {
                controller.onUpdateCategories('add', item);
              } else {
                controller.onUpdateCategories('remove', item);
              }
            },
          ));
        },
      ),
    ]);
  }

  Widget _tagButton(BuildContext context, String text, Function() onTap, bool isSelected, Color color) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.5) : null,
          borderRadius: ThemeRadius.big,
          border: Border.all(
            width: 1,
            color: color
          )
        ),
        child: Text(text, style: ThemeText.paragraph.copyWith(color: isSelected ? colorScheme(context).onSurface : color)),
      ),
    );
  }
}


Future<void> showTransactionFilter(BuildContext context, Function() updateFilter) {
  return Get.bottomSheet(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsetsGeometry.all(spacingUnit(2)),
        child: Column(children: [
          const GrabberIcon(),
          const VSpaceShort(),
          const TitleBasic(title: 'Filters', align: CrossAxisAlignment.center,),
          const VSpaceShort(),
          Expanded(
            child: HistoryFilter(),
          ),
          Padding(
            padding: EdgeInsets.all(spacingUnit(1)),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  updateFilter();
                  Get.back();
                },
                style: ThemeButton.btnBig.merge(ThemeButton.tonalPrimary(context)),
                child: Text('Update Result'.toUpperCase(), style: ThemeText.subtitle2)
              ),
            )
          ),
          const VSpace()
        ]),
      );
    }),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: colorScheme(context).surface,
  );
}
