import 'package:flutter/material.dart';
import 'product_header.dart';
import 'package:ui_web/common/constants.dart';

class QuantityControl extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color themeColor = ProductHeader.categoryColor("Fruits");

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (quantity > 1) onChanged(quantity - 1);
          },
          child: _quantityButton("-", themeColor),
        ),
        const SizedBox(width: 10),
        Text(
          quantity.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => onChanged(quantity + 1),
          child: _quantityButton("+", themeColor, gradient: true),
        ),
      ],
    );
  }

  Widget _quantityButton(String text, Color color, {bool gradient = false}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient ? gradientColor : null,
        color: gradient ? null : color.withOpacity(0.15),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: gradient ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}
