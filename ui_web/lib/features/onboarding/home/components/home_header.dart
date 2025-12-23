import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kDefaultPadding,
        28,
        kDefaultPadding,
        0,
      ),
      child: Row(
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Welcome\n",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                TextSpan(
                  text: "Ngọc Tường",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),

          ClipOval(
            child: Image.asset(
              'assets/images/avatar.jpg',
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
