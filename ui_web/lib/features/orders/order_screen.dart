// lib/screens/order_screen.dart

import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/data/model/product_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 0;

  final List<String> _tabs = [
    "Tất cả",
    "Chờ giao",
    "Đang giao",
    "Giao thành công",
    "Hủy đơn",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Đơn Hàng Từng Mua",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: textGreen,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildOrderTabs(),
          Expanded(
            child: _selectedIndex == 2
                ? ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: ProductOrder.sampleOrders.length,
                    itemBuilder: (_, index) => OrderItemWidget(
                      order: ProductOrder.sampleOrders[index],
                    ),
                  )
                : _buildEmptyOrder(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final selected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected ? textGreen : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: selected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEmptyOrder() {
    return const Center(
      child: Text(
        "Bạn chưa có đơn hàng nào!",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  final ProductOrder order;
  const OrderItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: AssetImage(order.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.name,
                      style: const TextStyle(color: Colors.green),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Số lượng: ${order.qty}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Tổng số tiền: "),
              Text(
                order.price,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
