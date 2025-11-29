import 'package:ewallet_app/widgets/app_button/tag_button.dart';
import 'package:flutter/material.dart';

final List<String> tagFilter = ['All', 'Game', 'Paket Data Indosat', 'Paket Data Telkomsel', 'Topup Gopay', 'Topup OVO'];

class TagFilter extends StatefulWidget {
  const TagFilter({super.key});

  @override
  State<TagFilter> createState() => _TagFilterState();
}

class _TagFilterState extends State<TagFilter> {
  final List<String> _selected = [tagFilter[0]];

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagFilter.length,
        itemBuilder: (context, index) {
          String item = tagFilter[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 4,
              right: 4
            ),
            child: TagButton(
              size: BtnSize.medium,
              text: item,
              selected: _selected.contains(item),
              onPressed: () {
                setState(() {
                  if (!_selected.contains(item)) {
                    _selected.add(item);
                  } else {
                    _selected.remove(item);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}