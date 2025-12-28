import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';

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

  final List orders = [];

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
            child: orders.isEmpty
                ? _buildEmptyOrder()
                : _buildOrderList(orders),
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
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final selected = _selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
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
                    fontWeight: FontWeight.w500,
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.shopping_cart_outlined, size: 90, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "Bạn chưa có đơn hàng nào!",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(List orders) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (_, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: Text("Đơn hàng #${index + 1}"),
            subtitle: const Text("Trạng thái: Đang xử lý"),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}
