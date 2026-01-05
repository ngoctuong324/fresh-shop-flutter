import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_web/data/model/product.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    final snapshot = await _db.collection('products').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Product(
        id: doc.id,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        image: data['image'] ?? '',
        category: data['category'] ?? '',
        price: (data['price'] as num).toDouble(),
        unit: data['unit'] ?? '',
        rate: (data['rate'] as num).toDouble(),
        isRecent: data['isRecent'] ?? false,
      );
    }).toList();
  }
}
