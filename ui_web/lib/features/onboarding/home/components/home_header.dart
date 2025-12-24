import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Welcome\n",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                TextSpan(
                  text: userName,
                  style: const TextStyle(
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
