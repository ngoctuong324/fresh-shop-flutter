import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/cart/cart_controller.dart';
import 'widgets/cart_item_tille.dart';
import 'widgets/cart_summary_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Consumer<CartController>(
        builder: (context, controller, _) {
          return Column(
            children: [
              Expanded(
                child: controller.isEmpty
                    ? const Center(
                        child: Text(
                          "Giỏ hàng đang trống!",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.items.length,
                        itemBuilder: (_, index) {
                          final item = controller.items[index];
                          return CartItemTile(
                            item: item,
                            onQuantityChanged: (val) =>
                                controller.updateQuantity(item.product, val),
                            onRemove: () =>
                                controller.removeProduct(item.product),
                          );
                        },
                      ),
              ),

              CartSummaryBar(
                totalPrice: controller.totalPrice,
                onCheckout: () {
                  if (controller.isEmpty) return;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
