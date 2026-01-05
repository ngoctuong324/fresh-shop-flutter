import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/home/home_screen.dart';
import 'package:ui_web/features/orders/order_screen.dart';
import 'package:ui_web/features/profile/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  const BottomNavigation({super.key, this.initialIndex = 0});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _index;

  final List<Widget> _pages = [
    const HomeScreen(),
    OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        height: 60,
        backgroundColor: backgroundColor,
        color: textGreen,
        buttonBackgroundColor: textGreen,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.local_shipping, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }
}
