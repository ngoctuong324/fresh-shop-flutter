import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:ui_web/data/model/product.dart';
import 'product_header.dart';
import 'quantity_control.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color themeColor = ProductHeader.categoryColor(product.category);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            RatingBar.builder(
              initialRating: product.rate,
              itemSize: 26,
              allowHalfRating: true,
              itemBuilder: (_, __) =>
                  const Icon(Icons.star_rounded, color: Colors.orange),
              onRatingUpdate: (_) {},
            ),
            const SizedBox(width: 6),
            Text(
              "(${product.rate})",
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            QuantityControl(quantity: quantity, onChanged: onQuantityChanged),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          "Description",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ReadMoreText(
          "${product.name} ${product.description}",
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: " Read More",
          trimExpandedText: " Read Less",
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black54,
          ),
          moreStyle: TextStyle(fontWeight: FontWeight.bold, color: themeColor),
          lessStyle: TextStyle(fontWeight: FontWeight.bold, color: themeColor),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
