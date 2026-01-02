import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import 'home_controller.dart';
import 'widgets/home_header.dart';
import 'widgets/search_box.dart';
import 'widgets/category_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/recent_shop_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? "User";

    return ChangeNotifierProvider(
      create: (_) {
        final controller = HomeController();
        controller.loadProducts();
        return controller;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(userName: name),
              const SizedBox(height: 20),
              const SearchBox(),
              const SizedBox(height: 20),
              const Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryBar(),
                      SizedBox(height: 16),
                      ProductGrid(),
                      SizedBox(height: 28),
                      RecentShopList(),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
