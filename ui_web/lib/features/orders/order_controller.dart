import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_web/data/model/product_order.dart';

class OrderController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersStream(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  List<OrderProduct> parseProducts(List<dynamic> productsData) {
    return productsData
        .whereType<Map<String, dynamic>>()
        .map((p) => OrderProduct.fromMap(p))
        .toList();
  }
}
