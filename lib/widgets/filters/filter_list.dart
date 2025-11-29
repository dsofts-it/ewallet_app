import 'package:ewallet_app/controller/history_filter_controller.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/app_button/tag_button.dart';
import 'package:ewallet_app/widgets/filters/history_filter.dart';
import 'package:ewallet_app/widgets/search/search_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterList extends StatefulWidget {
  const FilterList({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
    required this.onFiltered,
    this.withFilter = false,
    this.withSearch = false,
    this.onShowFilter,
    this.onSubmitSearch,
    this.textCtrl,
  });

  final List<String> items;
  final String selected;
  final Function(int) onSelected;
  final Function() onFiltered;
  final bool withFilter;
  final bool withSearch;
  final Function()? onShowFilter;
  final Function(String)? onSubmitSearch;
  final TextEditingController? textCtrl;

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  bool _showSearch = false;
  final HistoryFilterController controller = Get.put(HistoryFilterController());

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// TAG FILTER AND SEARCH INPUT
        Expanded(
          child: _showSearch ? Padding(
            padding: EdgeInsets.only(left: spacingUnit(2)),
            child: SizedBox(
              height: 36,
              child: SearchInput(
                textRef: widget.textCtrl!,
                onSubmitSearch: widget.onSubmitSearch,
                onClearSearch: () {
                  if(widget.onSubmitSearch != null) {
                    widget.onSubmitSearch!('');
                  }
                },
              ),
            ),
          ) : SizedBox(
            height: 24,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    String item = widget.items[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16 : 4,
                        right: 4
                      ),
                      child: TagButton(
                        size: BtnSize.medium,
                        text: item,
                        selected: widget.selected == item,
                        onPressed: () {
                          widget.onSelected(index);
                        }
                      ),
                    );
                  },
                ),
                widget.withSearch ? Container(
                  width: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        colorScheme(context).surface.withValues(alpha: 0),
                        colorScheme(context).surfaceContainerLow
                      ],
                    ),
                  ),
                ) : SizedBox.shrink()
              ],
            )
          ),
        ),

        /// SEARCH BUTTON ICON
        widget.withSearch && !_showSearch ? Padding(
          padding: EdgeInsets.only(top: 4, left: spacingUnit(1)),
          child: SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _showSearch = true;
                });
              },
              style: ThemeButton.primary,
              icon: Icon(Icons.search_rounded, size: 16),
            ),
          ),
        ) : SizedBox.shrink(),

        widget.withSearch && _showSearch ? Padding(
          padding: EdgeInsets.only(top: 4, left: spacingUnit(1)),
          child: SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _showSearch = false;
                });
              },
              style: ThemeButton.primary,
              icon: Icon(Icons.date_range_rounded, size: 16),
            ),
          ),
        ) : SizedBox.shrink(),

        /// FILTER ICON BUTTON
        widget.withFilter ? Padding(
          padding: EdgeInsets.only(top: 4, left: spacingUnit(1), right: spacingUnit(2)),
          child: SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              onPressed: () {
                showTransactionFilter(context, () {
                  widget.onFiltered();
                });
              },
              style: ThemeButton.primary,
              icon: Icon(Icons.tune, size: 16),
            ),
          ),
        ) : SizedBox.shrink()
      ],
    );
  }
}