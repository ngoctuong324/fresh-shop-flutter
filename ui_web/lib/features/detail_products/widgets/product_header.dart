import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/data/model/product.dart';
import 'package:ui_web/features/cart/cart_controller.dart';
import 'package:ui_web/features/cart/cart_screen.dart';

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
        Consumer<CartController>(
          builder: (context, cart, child) {
            int count = cart.items.length;

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: themeColor,
                      size: 30,
                    ),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        const SizedBox(width: 5),
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
          height: 360,
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
