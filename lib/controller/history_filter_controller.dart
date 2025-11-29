import 'package:ewallet_app/models/category_type.dart';
import 'package:ewallet_app/models/transaction.dart';
import 'package:get/get.dart';

class HistoryFilterController extends GetxController {
  var rawData = <dynamic>[].obs;
  var filteredHistory = <dynamic>[].obs;
  var status = <TransactionStatus>[].obs;
  var categories = <CategoryType>[].obs;
  var sortby = ''.obs;

  Future<void> loadItems(List<dynamic> items) async {
    filteredHistory.value = items.cast<dynamic>();
    rawData.value = items;
    update();
  }

  void onUpdateSortBy(String? val) {
    sortby.value = val ?? '';
    update();
  }

  void onUpdateStatus(TransactionStatus val) {
    if(status.contains(val)) {
      status.remove(val);
    } else {
      status.add(val);
    }
    update();
  }

  void onUpdateCategories(String type, CategoryType val) {
    if(type == 'add') {
      categories.add(val);
    } else {
      categories.remove(val);
    }
    update();
  }

  Future<void> onSearch(String text) async {
    final String searchText = text.trim().toLowerCase();

    final List<dynamic> results = rawData.where((item) {
      String combined = '';
      Map<String, dynamic> itemJson = item.toJson();
      final name = itemJson['name'] ?? '';
      final product = itemJson['productName'] ?? '';
      final subject = itemJson['subject'] ?? '';
      combined = '$name $product $subject'.toLowerCase();

      return combined.contains(searchText);
    }).toList();

    filteredHistory.value = results.cast<dynamic>();
    update();
  }

  Future<void> onFilterHistory() async {
    final List<dynamic> filteredItems = rawData.where((item) {
      bool matchStatus = status.isEmpty || status.contains(item.status);
      bool matchCategories = categories.isEmpty || categories.contains(item.category);

      return matchStatus && matchCategories;
    }).toList();

    filteredHistory.value = filteredItems.cast<dynamic>();
    filteredHistory.sort((a, b) {
      dynamic valueA;
      dynamic valueB;

      switch (sortby.value) {
        case 'date':
          valueA = a.transactionDate;
          valueB = b.transactionDate;
          break;
        case 'price':
          valueA = a.price;
          valueB = b.price;
          break;
        case 'status':
          valueA = a.status.toString().split('.').last;
          valueB = b.status.toString().split('.').last;
          break;
        case 'category':
          valueA = a.category.name;
          valueB = b.category.name;
          break;
        default:
          return 0; // No sorting if an invalid criteria is passed
      }

      return valueA.compareTo(valueB);
    });
    update();
  }
}

