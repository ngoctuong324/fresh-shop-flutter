import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/features/auth/login_page.dart';
import 'package:ui_web/features/cart/cart_controller.dart';
import 'package:ui_web/features/home/home_controller.dart';
import 'package:ui_web/features/checkout/place_order_controller.dart';
import 'package:ui_web/features/orders/order_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => PlaceOrderController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh Shop',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: LogIn(),
    );
  }
}
