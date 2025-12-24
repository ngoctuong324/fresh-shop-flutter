import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/home/home_screen_grocery.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _index = 0;
  final List<Widget> _pages = const [
    HomeScreenGrocery(),
    Center(child: Text('Cart')),
    Center(child: Text('Favorite')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _pages[_index],

      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        height: 60,
        backgroundColor: backgroundColor,
        color: textGreen,
        buttonBackgroundColor: textGreen,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.shopping_cart_outlined, color: Colors.white),
          Icon(Icons.favorite_border, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
