import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double kDefaultPadding = 20;
const backgroundColor = Color(0xFFf7f8fb);
const textGreen = Color(0xFF50bf6e);

const primaryGreen = Color(0xFF1B5E20);
const accentGreen = Color(0xFFC8E6C9);
const scaffoldBg = Color(0xFFFFFFFF);

const gradientColor = LinearGradient(
  colors: [Colors.green, Colors.greenAccent],
);

String formatVND(num price) {
  return "${NumberFormat('#,###', 'vi_VN').format(price)} VNĐ";
}
