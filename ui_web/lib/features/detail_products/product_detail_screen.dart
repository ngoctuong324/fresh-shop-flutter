import 'package:flutter/material.dart';
import 'package:ui_web/data/model/product.dart';
import 'widgets/product_header.dart';
import 'widgets/product_info_section.dart';
import 'widgets/add_to_cart_bar.dart';
import 'package:ui_web/common/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: ProductHeader.appBar(context, widget.product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductHeader(widget.product),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProductInfoSection(
                product: widget.product,
                quantity: quantity,
                onQuantityChanged: (val) => setState(() => quantity = val),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddToCartBar(
        product: widget.product,
        quantity: quantity,
        onQuantityChanged: (val) => setState(() => quantity = val),
      ),
    );
  }
}
