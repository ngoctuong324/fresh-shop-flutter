import 'package:flutter/material.dart';
import 'package:ui_web/data/model/product.dart';

class ProductHeader extends StatelessWidget {
  final Product product;
  const ProductHeader(this.product, {super.key});

  static AppBar appBar(BuildContext context, Product product) {
    Color themeColor = categoryColor(product.category);
    return AppBar(
      backgroundColor: themeColor.withOpacity(0.15),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new, color: themeColor),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart_outlined, color: themeColor),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  static Color categoryColor(String category) {
    switch (category) {
      case 'Vegetables':
        return Colors.orange;
      case 'Fruits':
        return Colors.lightGreen;
      case 'Meat':
        return Colors.blue;
      case 'Beverages':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = categoryColor(product.category);
    final size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 300,
          width: size.width,
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(230),
              bottomRight: Radius.circular(230),
            ),
          ),
        ),
        Positioned(
          bottom: -35,
          left: 0,
          right: 0,
          child: Hero(
            tag: product.image,
            child: Image.asset(
              product.assetImage,
              height: 340,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
