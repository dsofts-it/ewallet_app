import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/credit.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_shadow.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/grabber_icon.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/cards/product_landscape_card.dart';
import 'package:ewallet_app/widgets/product/detail/price_details.dart';
import 'package:ewallet_app/widgets/product/detail/product_detail.dart';
import 'package:flutter/material.dart';

class TopupList extends StatefulWidget {
  const TopupList({
    super.key,
    required this.creditItems,
    this.selectable = false,
    required this.scaffoldKey,
  });

  final List<Credit> creditItems;
  final bool selectable;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<TopupList> createState() => _TopupListState();
}

class _TopupListState extends State<TopupList> {
  PersistentBottomSheetController? _bottomSheetController;
  int? _selectedIndex;
  bool _showConfirm = false;
  final SelectedCreditModel _selected = SelectedCreditModel();

  void _onSelectItem(int index) {
    _selected.selectCredit(widget.creditItems[index]);
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
                CreditPriceDetails(notifier: _selected),
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

    return widget.creditItems.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: spacingUnit(2)),
      padding: EdgeInsets.only(
        top: spacingUnit(2),
        left: spacingUnit(2),
        right: spacingUnit(2),
        bottom: _showConfirm ? spacingUnit(20) : spacingUnit(3)
      ),
      itemCount: widget.creditItems.length,
      itemBuilder: (BuildContext context, int index) {
        return _itemBuilder(context, widget.creditItems[index], index);
      }
    ) : NoData(
      image: ImgApi.nodataVoucher,
      title: 'Search Product',
      desc: 'Topup credits and items with just one tap.',
    );
  }

  Widget _itemBuilder(BuildContext context, Credit item, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.selectable) {
          _onSelectItem(index);

          if(isPersistentBottomSheetClosed()) {
            _showPersistentBottomSheet();
          }
        } else {
          showProductDetail(context, item: item, withActionBtn: true);
        }
      },
      child: ProductLandscapeCard(
        title: '${item.amount.toStringAsFixed(0)} ${item.unit}',
        thumb: item.thumb,
        category: item.category,
        type: item.type,
        price: item.price,
        additionalWidget: item.description != null ? Text(item.description!, style: ThemeText.caption,) : null,
        discount: item.discount,
        hasPromo: item.isPromo,
        label: item.isPromo ? 'Promo' : null,
        points: item.points,
        isSelected: _selectedIndex == index && _showConfirm,
        onTapDetail: () {
          showProductDetail(context, item: item);
        },
      ),
    );
  }
}
