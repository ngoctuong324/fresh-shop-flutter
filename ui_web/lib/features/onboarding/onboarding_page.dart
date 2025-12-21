// import 'package:flutter/material.dart';
// import 'package:ui_web/app/app_routes.dart';
// import 'package:ui_web/common/widgets/primary_button.dart';

// class OnboardingPage extends StatelessWidget {
//   const OnboardingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.eco, size: 120, color: Colors.green),
//             const SizedBox(height: 24),
//             const Text(
//               'Fresh Shop',
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             const Text('Thực phẩm sạch – An toàn – Tươi ngon'),
//             const SizedBox(height: 40),
//             PrimaryButton(
//               title: 'Bắt đầu',
//               onPressed: () {
//                 Navigator.pushReplacementNamed(context, AppRoutes.login);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
