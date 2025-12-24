import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:ui_web/data/model/product.dart';
import 'package:ui_web/features/detail_products/widgets/product_header.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  const ProductDescription({super.key, required this.product});

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
        const SizedBox(height: 12),
        ReadMoreText(
          "${product.name} ${product.description}", // nối tên + description
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
      ],
    );
  }
}
