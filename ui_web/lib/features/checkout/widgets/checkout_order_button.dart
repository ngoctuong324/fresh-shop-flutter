import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';

class CheckoutOrderButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CheckoutOrderButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: textGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          "Đặt Hàng",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
