import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'package:ui_web/data/model/product.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];
  final Set<Product> _selectedProducts = {};
  bool isEditMode = false;

  List<CartItem> get items => _items;
  Set<Product> get selectedProducts => _selectedProducts;

  bool get isEmpty => _items.isEmpty;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    if (isEditMode) {
      return _items
          .where((item) => _selectedProducts.contains(item.product))
          .fold(0.0, (sum, item) => sum + item.totalPrice);
    } else {
      return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
    }
  }

  bool get isAllSelected =>
      _items.isNotEmpty && _selectedProducts.length == _items.length;

  void addProduct(Product product, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    _selectedProducts.remove(product);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (quantity <= 0) {
      removeProduct(product);
      return;
    }

    if (index >= 0) {
      _items[index].quantity = quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners();
  }

  void toggleSelect(Product product) {
    if (_selectedProducts.contains(product)) {
      _selectedProducts.remove(product);
    } else {
      _selectedProducts.add(product);
    }
    notifyListeners();
  }

  void toggleSelectAll() {
    if (isAllSelected) {
      _selectedProducts.clear();
    } else {
      _selectedProducts.clear();
      for (var item in _items) {
        _selectedProducts.add(item.product);
      }
    }
    notifyListeners();
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    if (!isEditMode) _selectedProducts.clear();
    notifyListeners();
  }

  void deleteSelected() {
    _items.removeWhere((item) => _selectedProducts.contains(item.product));
    _selectedProducts.clear();
    isEditMode = false;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _selectedProducts.clear();
    notifyListeners();
  }
}
