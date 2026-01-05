import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/cart/cart_controller.dart';
import 'package:ui_web/features/cart/widgets/cart_item_tille.dart';
import 'package:ui_web/features/checkout/order_checkout_screen.dart';
import 'widgets/cart_summary_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, controller, _) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: textGreen,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              "Giỏ Hàng",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            actions: [
              if (!controller.isEmpty)
                TextButton(
                  onPressed: controller.toggleEditMode,
                  child: Text(
                    controller.isEditMode ? "Xong" : "Chỉnh sửa",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          body: controller.isEmpty
              ? const Center(
                  child: Text(
                    "Giỏ hàng đang trống!",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Column(
                  children: [
                    if (controller.isEditMode)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: controller.isAllSelected,
                              onChanged: (_) => controller.toggleSelectAll(),
                            ),
                            const Text("Chọn tất cả"),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: controller.selectedProducts.isEmpty
                                  ? null
                                  : controller.deleteSelected,
                              icon: const Icon(Icons.delete),
                              label: const Text("Xóa"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                disabledBackgroundColor:
                                    Colors.redAccent.shade100,
                                foregroundColor: Colors.white,
                                disabledForegroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.items.length,
                        itemBuilder: (_, index) {
                          final item = controller.items[index];
                          return CartItemTile(
                            item: item,
                            isSelectable: controller.isEditMode,
                            isSelected: controller.selectedProducts.contains(
                              item.product,
                            ),
                            onSelectedChanged: (_) =>
                                controller.toggleSelect(item.product),
                            onQuantityChanged: (val) =>
                                controller.updateQuantity(item.product, val),
                            onRemove: () =>
                                controller.removeProduct(item.product),
                          );
                        },
                      ),
                    ),
                    if (!controller.isEditMode)
                      CartSummaryBar(
                        totalPrice: controller.totalPrice,
                        onCheckout: () {
                          if (controller.isEmpty) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OrderCheckoutScreen(),
                            ),
                          );
                        },
                      ),
                  ],
                ),
        );
      },
    );
  }
}
