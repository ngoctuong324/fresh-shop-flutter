import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double kDefaultPadding = 20;
const onboardbackground = Color(0xFFe9f5e8);
const backgroundColor = Color(0xFFf7f8fb);
const textGreen = Color(0xFF50bf6e);

const gradientColor = LinearGradient(
  colors: [Colors.green, Colors.greenAccent],
);

String formatVND(num price) {
  return "${NumberFormat('#,###', 'vi_VN').format(price)} VNĐ";
}
