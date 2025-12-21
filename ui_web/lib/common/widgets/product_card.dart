// import 'package:flutter/material.dart';
// import 'package:ui_web/data/model/product.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             const Icon(Icons.shopping_bag, size: 48, color: Colors.green),
//             const SizedBox(height: 8),
//             Text(
//               product.name,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('${product.price} đ'),
//           ],
//         ),
//       ),
//     );
//   }
// }
