import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';

class CheckoutPayment extends StatelessWidget {
  final int paymentMethod;
  final ValueChanged<int> onChanged;

  const CheckoutPayment({
    super.key,
    required this.paymentMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hình thức thanh toán",
            style: TextStyle(fontWeight: FontWeight.bold, color: textGreen),
          ),
          const SizedBox(height: 12),
          _tile(0, "Tiền mặt khi nhận hàng"),
          _tile(1, "Chuyển khoản"),
        ],
      ),
    );
  }

  Widget _tile(int value, String title) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: paymentMethod,
            activeColor: textGreen,
            onChanged: (v) => onChanged(v!),
          ),
          Text(title),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(6),
  );
}
