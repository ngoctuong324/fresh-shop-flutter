import 'package:flutter/material.dart';
import 'package:ui_web/data/model/product.dart';
import 'package:ui_web/data/services/firestore_service.dart';

class HomeController extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();

  int selectedIndex = 0;

  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  List<String> categories = ['All'];

  Future<void> loadProducts() async {
    allProducts = await _service.getProducts();

    final firebaseCategories = allProducts
        .map((e) => e.category)
        .toSet()
        .toList();

    categories = ['All', ...firebaseCategories];

    filteredProducts = allProducts;
    notifyListeners();
  }

  void search(String value) {
    filteredProducts = allProducts
        .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void selectCategory(int index, String category) {
    selectedIndex = index;

    if (category == 'All') {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts
          .where((e) => e.category == category)
          .toList();
    }
    notifyListeners();
  }
}
