import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'package:ui_web/data/model/product.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addProduct(Product product, int quantity) {
    final index = _items.indexWhere((item) => item.product == product);

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.removeWhere((item) => item.product == product);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    final index = _items.indexWhere((item) => item.product == product);

    if (index >= 0) {
      _items[index].quantity = quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }

    if (quantity <= 0) {
      _items.removeWhere((item) => item.product == product);
    }

    notifyListeners();
  }

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isEmpty => _items.isEmpty;
}
