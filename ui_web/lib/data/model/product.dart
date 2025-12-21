import 'package:flutter/material.dart';

List<String> groceryCategories = [
  'All',
  'Vegetables',
  'Fruits',
  'Meat',
  'Beverages',
];

class Grocery {
  final String description;
  final String name;
  final String image;
  final String category;

  final double rate;
  final int price;
  final Color color;
  final bool isRecent;

  Grocery({
    required this.category,
    required this.image,
    required this.description,
    required this.name,
    required this.rate,
    required this.color,
    required this.price,
    required this.isRecent,
  });
}

List<Grocery> groceryItems = [
  Grocery(
    category: 'Vegetables',
    image: 'assets/images/apple.png',
    name: 'Quả Táo',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.orange,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/chuoi.png',
    name: 'Chuối',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/buoi.png',
    name: 'Bưởi',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/thanh-long.png',
    name: 'Thanh Long',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/xoai.png',
    name: 'Xoài',
    isRecent: true,
    price: 15000,
    rate: 4.2,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/dua-luoi.png',
    name: 'Dưa Lưới',
    isRecent: true,
    price: 35000,
    rate: 4.8,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/kiwi.png',
    name: 'Kiwi',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/quyt.png',
    name: 'Quýt',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Fruits',
    image: 'assets/images/dua-gang.png',
    name: 'Dưa Gang',
    isRecent: true,
    price: 35000,
    rate: 4.8,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Grocery(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-oi.jpg',
    name: 'Nước Ép Ổi',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),
  Grocery(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-thom.jpg',
    name: 'Nước Ép Thơm',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),
];

const description =
    "Fruits and vegetables are an essential part of a healthy diet, providing "
    "the body with a wide range of nutrients, vitamins, and minerals that are "
    "crucial for overall well-being. Regular consumption helps improve heart "
    "health, digestion, and overall immunity.";
