import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_web/common/constants.dart';
import 'home_controller.dart';
import 'components/home_header.dart';
import 'components/search_box.dart';
import 'components/category_bar.dart';
import 'components/product_grid.dart';
import 'components/recent_shop_list.dart';

class HomeScreenGrocery extends StatelessWidget {
  const HomeScreenGrocery({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                HomeHeader(),
                SizedBox(height: 24),
                SearchBox(),
                SizedBox(height: 20),
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
      ),
    );
  }
}
