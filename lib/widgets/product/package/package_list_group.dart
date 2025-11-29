import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/cards/package_landscape_card.dart';
import 'package:ewallet_app/widgets/product/detail/package_detail.dart';
import 'package:ewallet_app/widgets/product/detail/price_details.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:grouped_list/grouped_list.dart';

class PackageListGroup extends StatefulWidget {
  const PackageListGroup({
    super.key,
    required this.packageItems,
    this.selectable = false,
    required this.scaffoldKey,
    this.noScroll = false,
    this.scrollController,
  });

  final List<Package> packageItems;
  final bool selectable;
  final bool noScroll;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ScrollController? scrollController;

  @override
  State<PackageListGroup> createState() => _PackageListGroupState();
}

class _PackageListGroupState extends State<PackageListGroup> {
  PersistentBottomSheetController? _bottomSheetController;
  int? _selectedIndex;
  bool _showConfirm = false;
  final SelectedPackageModel _selected = SelectedPackageModel();

  void _onSelectItem(int index) {
    _selected.selectPackage(widget.packageItems[index]);
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showDetail(Map item) {
    Get.bottomSheet(
      Wrap(children: [
        VSpaceShort(),
        GrabberIcon(),
        VSpaceShort(),
        PackageDetail(
          name: item['name'],
          image: item['images'],
          category: item['category'],
          description: item['description'],
          price: item['price'],
          discount: item['discount'],
          features: item['features'],
          isPromo: item['discount'] > 0,
          points: item['points'],
          vendor: item['vendor'],
        )
      ]),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: colorScheme(context).surface,
    );
  }

  void _closeBottomSheet() {
    setState(() {
      _showConfirm = false;
    });
    _bottomSheetController?.close();
  }

  void _showPersistentBottomSheet() {
    setState(() {
      _showConfirm = true;
    });

    _bottomSheetController = widget.scaffoldKey.currentState!.showBottomSheet(
      (BuildContext context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
            color: colorScheme(context).surface,
            boxShadow: [ThemeShade.shadeMedium(context)],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(spacingUnit(2)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _closeBottomSheet,
                  child: const GrabberIcon()
                ),
                const VSpaceShort(),
                PackagePriceDetails(notifier: _selected),
              ],
            ),
          ),
        );
      },
    );

    _bottomSheetController?.closed.then((_) {
      _bottomSheetController = null;
    });
  }

  bool isPersistentBottomSheetClosed() {
    return _bottomSheetController == null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    List<Map<String, dynamic>> groupedItems = widget.packageItems.asMap().entries.map((entry) {
      int idx = entry.key;
      Package item = entry.value;
      return {
        'index': idx,
        'name': item.name,
        'images': item.images,
        'thumb': item.thumb,
        'vendor': item.vendor,
        'category': item.category,
        'groupName': item.groupName,
        'description': item.description,
        'price': item.price,
        'discount': item.discount,
        'features': item.features,
        'points': item.points,
        'timeleft': item.timeleft,
      };
    }).toList();

    return widget.packageItems.isNotEmpty ? GroupedListView<dynamic, String>(
      elements: groupedItems,
      groupBy: (element) => element['groupName'],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
      order: GroupedListOrder.DESC,
      padding: EdgeInsets.only(bottom: _showConfirm ? spacingUnit(20) : spacingUnit(3)),
      useStickyGroupSeparators: true,
      controller: widget.scrollController,
      physics: widget.noScroll ? NeverScrollableScrollPhysics() : null,
      groupStickyHeaderBuilder: (dynamic value) => Container(
        color: colorScheme(context).surfaceContainerLow,
        padding: EdgeInsets.symmetric(vertical: spacingUnit(1), horizontal: spacingUnit(2),),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? ThemePalette.primaryDark : colorScheme(context).surfaceDim,
                borderRadius: ThemeRadius.big
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: 4),
                child: Text(
                  value['groupName'].toString(),
                  textAlign: TextAlign.start,
                  style: ThemeText.paragraphBold
                ),
              ),
            ),
            Spacer(),
          ],
        )
      ),
      groupSeparatorBuilder: (String value) => Container(
        padding: EdgeInsets.symmetric(vertical: spacingUnit(1), horizontal: spacingUnit(2),),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? ThemePalette.primaryDark : colorScheme(context).surfaceDim,
                borderRadius: ThemeRadius.big
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: 4),
                child: Text(
                  value,
                  textAlign: TextAlign.start,
                  style: ThemeText.paragraphBold
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      itemBuilder: (c, element) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: spacingUnit(1)),
          child: _itemBuilder(context, element)
        );
      },
    ) : NoData(
      image: ImgApi.nodataPackage,
      title: 'Search Packages',
      desc: 'Top up your packages instantly, anywhere you go.',
    );
  }

  Widget _itemBuilder(BuildContext context, Map item){
    return GestureDetector(
      onTap: () {
        if (widget.selectable) {
          _onSelectItem(item['index']);
          if(isPersistentBottomSheetClosed()) {
            _showPersistentBottomSheet();
          }
        } else {
          _showDetail(item);
        }
      },
      child: PackageLandscapeCard(
        image: item['thumb'],
        name: item['name'],
        price: item['price'],
        discount: item['discount'],
        feature1: item['features'].length > 0 ? item['features'][0] : null,
        feature2: item['features'].length > 1 ? item['features'][1] : null,
        hasPromo: item['discount'] > 0,
        points: item['points'],
        vendor: item['vendor'],
        label: item['discount'] > 0 ? 'Promo' : null,
        isSelected: _selectedIndex == item['index'] && _showConfirm,
        onTapDetail: () {
          _showDetail(item);
        },
      ),
    );
  }
}
