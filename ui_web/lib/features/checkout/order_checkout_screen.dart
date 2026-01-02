import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/data/model/shipping_address_model.dart';
import 'package:ui_web/features/cart/cart_controller.dart';
import 'package:ui_web/features/checkout/order_success_screen.dart';
import 'package:ui_web/features/checkout/widgets/select_address_screen.dart';
import 'widgets/checkout_address.dart';
import 'widgets/checkout_product_list.dart';
import 'widgets/checkout_summary.dart';
import 'widgets/checkout_payment.dart';
import 'widgets/checkout_order_button.dart';

class OrderCheckoutScreen extends StatefulWidget {
  const OrderCheckoutScreen({super.key});

  @override
  State<OrderCheckoutScreen> createState() => _OrderCheckoutScreenState();
}

class _OrderCheckoutScreenState extends State<OrderCheckoutScreen> {
  int paymentMethod = 0;
  ShippingAddressModel? deliveryAddress;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('addresses')
        .doc('default')
        .get();

    if (doc.exists) {
      setState(() {
        deliveryAddress = ShippingAddressModel.fromMap(doc.data()!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: textGreen,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Xác Nhận Đơn Hàng",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            CheckoutAddress(
              address: deliveryAddress,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SelectAddressScreen(),
                  ),
                );

                if (result != null && result is ShippingAddressModel) {
                  setState(() {
                    deliveryAddress = result;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  CheckoutProductList(cart: cart),
                  const SizedBox(height: 16),
                  CheckoutSummary(cart: cart),
                  const SizedBox(height: 16),
                  CheckoutPayment(
                    paymentMethod: paymentMethod,
                    onChanged: (v) => setState(() => paymentMethod = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            CheckoutOrderButton(
              onPressed: () {
                if (deliveryAddress == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Vui lòng chọn địa chỉ giao hàng"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }

                if (cart.items.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Giỏ hàng của bạn đang trống"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
