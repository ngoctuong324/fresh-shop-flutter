  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:ui_web/common/constants.dart';
  import 'package:ui_web/data/model/shipping_address_model.dart';
  import 'package:ui_web/features/cart/cart_controller.dart';
  import 'package:ui_web/features/checkout/place_order_controller.dart';
  import 'package:ui_web/features/checkout/widgets/checkout_address.dart';
  import 'package:ui_web/features/checkout/widgets/checkout_order_button.dart';
  import 'package:ui_web/features/checkout/widgets/checkout_payment.dart';
  import 'package:ui_web/features/checkout/widgets/checkout_product_list.dart';
  import 'package:ui_web/features/checkout/widgets/checkout_summary.dart';
  import 'package:ui_web/features/checkout/widgets/select_address_screen.dart';
  import 'order_success_screen.dart';

  class OrderCheckoutScreen extends StatefulWidget {
    const OrderCheckoutScreen({super.key});

    @override
    State<OrderCheckoutScreen> createState() => _OrderCheckoutScreenState();
  }

  class _OrderCheckoutScreenState extends State<OrderCheckoutScreen> {
    ShippingAddressModel? selectedAddress;
    int paymentMethod = 0;
    static const int shippingFee = 15000;

    @override
    Widget build(BuildContext context) {
      final cart = Provider.of<CartController>(context);
      final orderController = Provider.of<PlaceOrderController>(
        context,
        listen: false,
      );

      return Scaffold(
        appBar: AppBar(
          backgroundColor: textGreen,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("Thanh toán", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutAddress(
                address: selectedAddress,
                onTap: () async {
                  final address = await Navigator.push<ShippingAddressModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SelectAddressScreen(),
                    ),
                  );
                  if (address != null) {
                    setState(() {
                      selectedAddress = address;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              CheckoutProductList(cart: cart),
              const SizedBox(height: 16),

              CheckoutSummary(cart: cart),
              const SizedBox(height: 16),

              CheckoutPayment(
                paymentMethod: paymentMethod,
                onChanged: (val) {
                  setState(() {
                    paymentMethod = val;
                  });
                },
              ),
              const SizedBox(height: 1),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: CheckoutOrderButton(
            onPressed: selectedAddress == null || cart.isEmpty
                ? null
                : () async {
                    try {
                      await orderController.placeOrder(
                        cart: cart,
                        address: selectedAddress!,
                        paymentMethod: paymentMethod,
                        shippingFee: shippingFee,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderSuccessScreen(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
          ),
        ),
      );
    }
  }
