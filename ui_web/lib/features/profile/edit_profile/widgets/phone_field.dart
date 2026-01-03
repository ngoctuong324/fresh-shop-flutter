import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: "Số điện thoại",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Số điện thoại không được để trống";
        }
        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
          return "Số điện thoại phải đủ 10 số";
        }
        return null;
      },
    );
  }
}
