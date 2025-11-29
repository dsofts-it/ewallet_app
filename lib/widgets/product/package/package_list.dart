import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/package.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/cards/package_portrait_card.dart';
import 'package:ewallet_app/widgets/product/detail/package_detail.dart';
import 'package:ewallet_app/widgets/product/detail/price_details.dart';
import 'package:flutter/material.dart';

class PackageList extends StatefulWidget {
  const PackageList({
    super.key,
    required this.packageItems,
    this.selectable = false,
    required this.scaffoldKey,
  });

  final List<Package> packageItems;
  final bool selectable;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
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

    return widget.packageItems.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: spacingUnit(4)),
      padding: EdgeInsets.only(
        top: spacingUnit(2),
        left: spacingUnit(1),
        right: spacingUnit(1),
        bottom: _showConfirm ? spacingUnit(20) : spacingUnit(3)
      ),
      itemCount: widget.packageItems.length,
      itemBuilder: (BuildContext context, int index) {
        return _itemBuilder(context, widget.packageItems[index], index);
      }
    ) : NoData(
      image: ImgApi.nodataPackage,
      title: 'Search Packages',
      desc: 'Top up your packages instantly, anywhere you go.',
    );
  }

  Widget _itemBuilder(BuildContext context, Package item, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.selectable) {
          _onSelectItem(index);

          if(isPersistentBottomSheetClosed()) {
            _showPersistentBottomSheet();
          }
        } else {
          showPackageDetail(context, item: item, withActionBtn: true);
        }
      },
      child: PackagePortraitCard(
        image: item.images,
        name: item.name,
        price: item.price,
        discount: item.discount,
        feature1: item.features!.isNotEmpty ? item.features![0] : null,
        feature2: item.features!.length > 1 ? item.features![1] : null,
        points: item.points,
        label: item.discount > 0 ? 'Promo' : null,
        isSelected: _selectedIndex == index && _showConfirm,
        biggerThumb: true,
        onTapDetail: () {
          showPackageDetail(context, item: item);
        },
      ),
    );
  }
}
