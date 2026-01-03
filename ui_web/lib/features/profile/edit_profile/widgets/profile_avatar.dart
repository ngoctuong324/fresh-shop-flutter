import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: textGreen.withOpacity(0.5),
      child: const Icon(Icons.person, size: 50, color: Colors.white),
    );
  }
}
