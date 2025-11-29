import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/voucher.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/payment/vouchers/voucher_list.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class VoucherInfo extends StatefulWidget {
  const VoucherInfo({super.key});

  @override
  State<VoucherInfo> createState() => _VoucherInfoState();
}

class _VoucherInfoState extends State<VoucherInfo> {
  final List<Voucher> _selectedVouchers = [];

  void updateVoucherList(String type, Voucher item) {
    setState(() {
      if (type == 'add') {
        _selectedVouchers.add(item);
      } else {
        _selectedVouchers.remove(item);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
     void showVoucherList() async {
      Get.bottomSheet(
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return VoucherList(
            selectedVouchers: _selectedVouchers,
            onSelected: (type, item) {
              setState(() {
                updateVoucherList(type, item);
              });
            },
          );
        }),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: colorScheme(context).surface,
      );
    }
    
    return InkWell(
      onTap: () {
        showVoucherList();
      },
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: ThemeRadius.medium,
          gradient: ThemePalette.gradientMixedAllMain,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spacingUnit(2), horizontal: spacingUnit(1)),
          decoration: BoxDecoration(
            borderRadius: ThemeRadius.medium,
            color: colorScheme(context).surfaceContainerLow
          ),
          child: _selectedVouchers.isNotEmpty ? Row(children: [
            Wrap(
              spacing: 4.0,
              children: _selectedVouchers.asMap().entries.map((entry) {
                int index = entry.key;
                Voucher item = entry.value;
        
                if (index > 1) {
                  return Container();
                }
                return Container(
                  width: 100,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: ThemeRadius.medium,
                    border: Border.all(width: 1, color: item.color)
                  ),
                  child: Text(item.title, style: ThemeText.caption, overflow: TextOverflow.ellipsis,)
                );
              }).toList(),
            ),
            _selectedVouchers.length > 2 ? Text('${_selectedVouchers.length - 2} more...', style: ThemeText.caption,) : Container(),
            const Spacer(),
            Text('CHANGE', style: ThemeText.paragraph.copyWith(color: colorScheme(context).onSecondaryContainer, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, color: colorScheme(context).onSecondaryContainer, size: 11),
          ]) : Row(children: [
            Image.asset(ImgApi.iconGrdTicket, width: 24),
            const SizedBox(width: 4),
            Text('5 Vouchers Available', style: ThemeText.paragraph.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text('USE VOUCHERS', style: ThemeText.paragraph.copyWith(color: colorScheme(context).onSecondaryContainer, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, color: colorScheme(context).onSecondaryContainer, size: 11),
          ])
        ),
      ),
    );
  }
}

