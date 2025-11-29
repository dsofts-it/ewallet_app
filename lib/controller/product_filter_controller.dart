import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ewallet_app/models/credit.dart';

class ProductFilterController extends GetxController {
  var rawData = <Credit>[].obs;
  var filteredProduct = <Credit>[].obs;
  var promos = <String>[].obs;
  var price = RangeValues(10, 50).obs;
  var vendors = <String>[].obs;
  var sortby = ''.obs;

  void loadItems(List<Credit> items) async {
    filteredProduct.value = items;
    rawData.value = items;
    update();
  }

  void onUpdatePromo(String val) {
    if(promos.contains(val)) {
      promos.remove(val);
    } else {
      promos.add(val);
    }
    update();
  }

  void onChangePrice(RangeValues val) {
    price.value = val;
    update();
  }

  void onUpdateVendor(String type, String val) {
    if(type == 'remove') {
      vendors.remove(val);
    } else {
      vendors.add(val);
    }
    update();
  }

  void onUpdateSortBy(String? val) {
    sortby.value = val ?? '';
    update();
  }

  Future<void> onFilterProduct() async {
    final List<Credit> filteredItems = rawData.where((item) {
      bool matchPromo = promos.isEmpty || promos.contains('ispromo') && item.isPromo;
      bool matchPrice = item.price >= price.value.start && item.price <= price.value.end;
      bool matchVedors = vendors.isEmpty || vendors.contains(item.vendor?.name);

      return matchPromo && matchPrice && matchVedors;
    }).toList();

    filteredProduct.value = filteredItems;
    filteredProduct.sort((a, b) {
      dynamic valueA;
      dynamic valueB;

      switch (sortby.value) {
        case 'amount':
          valueA = a.amount;
          valueB = b.amount;
          break;
        case 'price':
          valueA = a.price;
          valueB = b.price;
          break;
        case 'discount':
          valueA = a.discount;
          valueB = b.discount;
          break;
        case 'vendor':
          valueA = a.vendor!.name;
          valueB = b.vendor!.name;
          break;
        default:
          return 0; // No sorting if an invalid criteria is passed
      }

      return valueA.compareTo(valueB);
    });

    update();
  }
}
