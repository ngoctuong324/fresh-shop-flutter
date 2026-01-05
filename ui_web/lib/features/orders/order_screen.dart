import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/orders/order_controller.dart';
import 'package:ui_web/features/orders/widgets/order_item_widget.dart';
import 'package:ui_web/features/orders/widgets/order_tab.dart';

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

  final Map<int, String> _statusMapping = {
    1: 'pending',
    2: 'shipping',
    3: 'delivered',
    4: 'cancel',
  };

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return const Scaffold(body: Center(child: Text("Bạn chưa đăng nhập!")));
    }

    final orderController = Provider.of<OrderController>(context);

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
          OrderTab(
            tabs: _tabs,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: orderController.getOrdersStream(userId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Lỗi truy vấn: ${snapshot.error}\n\nLưu ý: Nếu lỗi 'FAILED_PRECONDITION', hãy nhấn vào link trong Debug Console để tạo Index.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Bạn chưa có đơn hàng nào!"));
                }

                final filteredOrders = snapshot.data!.docs.where((doc) {
                  if (_selectedIndex == 0) return true;
                  final status = (doc.data()['status'] ?? '')
                      .toString()
                      .toLowerCase();
                  final filterStatus = (_statusMapping[_selectedIndex] ?? '')
                      .toLowerCase();
                  return status == filterStatus;
                }).toList();

                if (filteredOrders.isEmpty) {
                  return const Center(
                    child: Text("Không có đơn hàng nào ở mục này!"),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final orderData = filteredOrders[index].data();
                    final productsData =
                        (orderData['products'] as List<dynamic>?) ?? [];
                    final products = orderController.parseProducts(
                      productsData,
                    );
                    final address =
                        orderData['address'] as Map<String, dynamic>? ?? {};
                    final totalPrice =
                        (orderData['totalPrice'] as num?)?.toDouble() ?? 0;
                    final status = orderData['status'] as String? ?? '';

                    return OrderItemWidget(
                      orderId: filteredOrders[index].id,
                      products: products,
                      address: address,
                      totalPrice: totalPrice,
                      status: status,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
