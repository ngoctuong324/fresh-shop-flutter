import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_web/features/cart/cart_controller.dart';
import 'package:ui_web/data/model/shipping_address_model.dart';

class PlaceOrderController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> placeOrder({
    required CartController cart,
    required ShippingAddressModel address,
    required int paymentMethod,
    required int shippingFee,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception("Bạn chưa đăng nhập");

    if (cart.isEmpty) throw Exception("Giỏ hàng đang trống");

    final orderData = {
      'userId': userId,
      'address': {
        'fullName': address.fullName,
        'phone': address.phone,
        'detail': address.detail,
        'ward': address.ward,
        'district': address.district,
        'province': address.province,
      },
      'paymentMethod': paymentMethod,
      'shippingFee': shippingFee,
      'totalPrice': cart.totalPrice + shippingFee,
      'products': cart.items
          .map(
            (item) => {
              'productId': item.product.id,
              'name': item.product.name,
              'price': item.product.price,
              'quantity': item.quantity,
              'totalPrice': item.totalPrice,
              'image': item.product.image,
            },
          )
          .toList(),
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await _firestore.collection('orders').add(orderData);
      cart.items.clear();
      cart.notifyListeners();
    } catch (e) {
      throw Exception("Đặt hàng thất bại: $e");
    }
  }
}
