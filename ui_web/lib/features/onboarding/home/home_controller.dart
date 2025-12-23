import 'package:flutter/material.dart';
import 'package:ui_web/data/model/product.dart';

class HomeController extends ChangeNotifier {
  int selectedIndex = 0;

  List<Product> allProducts = productItems;
  List<Product> filteredProducts = productItems;

  void search(String value) {
    filteredProducts = allProducts
        .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void selectCategory(int index, String category) {
    selectedIndex = index;

    if (category.toLowerCase() == 'all') {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts
          .where((e) => e.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    notifyListeners();
  }
}
