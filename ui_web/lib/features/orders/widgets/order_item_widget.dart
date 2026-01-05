import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/data/model/product_order.dart';

class OrderItemWidget extends StatelessWidget {
  final String orderId;
  final List<OrderProduct> products;
  final Map<String, dynamic> address;
  final double totalPrice;
  final String status;

  const OrderItemWidget({
    super.key,
    required this.orderId,
    required this.products,
    required this.address,
    required this.totalPrice,
    required this.status,
  });

  Future<void> _cancelOrder(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update(
        {'status': 'cancel'},
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đã hủy đơn hàng thành công")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Lỗi khi hủy đơn: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 4, right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: textGreen.withOpacity(0.03),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.receipt_long_outlined,
                      size: 18,
                      color: textGreen,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Đơn hàng #${orderId.substring(0, 8).toUpperCase()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textGreen,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                _buildStatusChip(status),
              ],
            ),
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Color(0xFFF0F0F0),
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final p = products[index];
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                          image: p.image != null && p.image!.isNotEmpty
                              ? AssetImage('assets/images/${p.image!}')
                              : const AssetImage('assets/images/default.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textGreen,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Số lượng: ${p.quantity}",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatVND(p.totalPrice),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textGreen,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Icon(
                        Icons.near_me_outlined,
                        size: 16,
                        color: textGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "${address['fullName']} • ${address['phone']}\n${address['detail']}, ${address['ward']}, ${address['district']}, ${address['province']}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Tổng thanh toán",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      formatVND(totalPrice),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),

                if (status == 'pending') ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _showCancelDialog(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Hủy đơn hàng",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    IconData icon;
    String text;

    switch (status) {
      case 'pending':
        color = Colors.orange;
        icon = Icons.access_time_filled;
        text = "Chờ giao";
        break;
      case 'shipping':
        color = Colors.blue;
        icon = Icons.local_shipping;
        text = "Đang giao";
        break;
      case 'delivered':
        color = Colors.green;
        icon = Icons.check_circle;
        text = "Thành công";
        break;
      case 'cancel':
        color = Colors.red;
        icon = Icons.cancel;
        text = "Đã hủy";
        break;
      default:
        color = Colors.black;
        icon = Icons.help;
        text = status.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String formatVND(num price) {
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(price);
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Xác nhận hủy"),
        content: const Text("Bạn có chắc chắn muốn hủy đơn hàng này không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Không", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelOrder(context);
            },
            child: const Text(
              "Có",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
