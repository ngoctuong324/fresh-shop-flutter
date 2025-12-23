import 'package:flutter/material.dart';

List<String> productCategories = [
  'All',
  'Vegetables',
  'Fruits',
  'Meat',
  'Beverages',
];

class Product {
  final String description;
  final String name;
  final String image;
  final String category;

  final double rate;
  final int price;
  final Color color;
  final bool isRecent;

  Product({
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

List<Product> productItems = [
  Product(
    category: 'Vegetables',
    image: 'assets/images/cai-thao.png',
    name: 'Cải Thảo',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.orange,
    description: description,
  ),

  Product(
    category: 'Vegetables',
    image: 'assets/images/brocoli.png',
    name: 'Bông Cải Trắng',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.orange,
    description: description,
  ),

  Product(
    category: 'Vegetables',
    image: 'assets/images/cu-cai-duong.png',
    name: 'Củ Cải Đường',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.orange,
    description: description,
  ),

  Product(
    category: 'Vegetables',
    image: 'assets/images/ca-tim.png',
    name: 'Cà Tím',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.orange,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/chuoi.png',
    name: 'Chuối',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/buoi.png',
    name: 'Bưởi',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/thanh-long.png',
    name: 'Thanh Long',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/xoai.png',
    name: 'Xoài',
    isRecent: true,
    price: 15000,
    rate: 4.2,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/dua-luoi.png',
    name: 'Dưa Lưới',
    isRecent: true,
    price: 35000,
    rate: 4.8,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/kiwi.png',
    name: 'Kiwi',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/quyt.png',
    name: 'Quýt',
    isRecent: false,
    price: 20000,
    rate: 4.5,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Fruits',
    image: 'assets/images/dua-gang.png',
    name: 'Dưa Gang',
    isRecent: true,
    price: 35000,
    rate: 4.8,
    color: Colors.lightGreenAccent,
    description: description,
  ),

  Product(
    category: 'Meat',
    image: 'assets/images/suon-heo.png',
    name: 'Sườn Heo',
    isRecent: true,
    price: 35000,
    rate: 4.8,
    color: Colors.lightBlueAccent,
    description: description,
  ),

  Product(
    category: 'Meat',
    image: 'assets/images/thit-bo.png',
    name: 'Thịt Bò',
    isRecent: true,
    price: 35000,
    rate: 4.8,
    color: Colors.lightBlueAccent,
    description: description,
  ),

  Product(
    category: 'Meat',
    image: 'assets/images/suon-cuu.png',
    name: 'Sườn Cừu',
    isRecent: false,
    price: 35000,
    rate: 4.8,
    color: Colors.lightBlueAccent,
    description: description,
  ),

  Product(
    category: 'Meat',
    image: 'assets/images/thit-ba-chi.png',
    name: 'Thịt Ba Chỉ Heo',
    isRecent: false,
    price: 35000,
    rate: 4.8,
    color: Colors.lightBlueAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-oi.jpg',
    name: 'Nước Ép Ổi',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-thom.jpg',
    name: 'Nước Ép Thơm',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-thom-dau.jpg',
    name: 'Nước Ép Thơm Dâu',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-ca-rot.jpg',
    name: 'Nước Ép Cà Rốt',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-luu.jpg',
    name: 'Nước Ép Lựu',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-dua-hau.jpg',
    name: 'Nước Ép Dưa Hấu',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-can-tay.jpg',
    name: 'Nước Ép Cần Tây',
    isRecent: false,
    price: 10000,
    rate: 4.4,
    color: Colors.pinkAccent,
    description: description,
  ),

  Product(
    category: 'Beverages',
    image: 'assets/images/nuoc-ep-cam.jpg',
    name: 'Nước Ép Cam',
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
