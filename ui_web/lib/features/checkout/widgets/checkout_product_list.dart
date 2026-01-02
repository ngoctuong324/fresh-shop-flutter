import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/cart/cart_controller.dart';

class CheckoutProductList extends StatelessWidget {
  final CartController cart;

  const CheckoutProductList({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        children: cart.items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    item.product.assetImage,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textGreen,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("Số lượng: ${item.quantity}"),
                    ],
                  ),
                ),
                Text(
                  formatVND(item.product.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.yellow[50],
    borderRadius: BorderRadius.circular(10),
  );
}
