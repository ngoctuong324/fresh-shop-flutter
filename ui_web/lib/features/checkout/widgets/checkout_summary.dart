import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/cart/cart_controller.dart';

class CheckoutSummary extends StatelessWidget {
  final CartController cart;
  const CheckoutSummary({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    const shippingFee = 15000;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _row("Tiền hàng", formatVND(cart.totalPrice)),
          const SizedBox(height: 8),
          _row("Phí giao hàng", formatVND(shippingFee)),
          const Divider(height: 24),
          _row(
            "Tổng cộng", 
            formatVND(cart.totalPrice + shippingFee),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _row(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(6),
  );
}
