import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/address/add_address_screen.dart';
import 'package:ui_web/features/auth/login_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/profile_menu_item.dart';
import 'edit_profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundColor: textGreen.withOpacity(0.5),
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 25),

            RichText(
              text: TextSpan(
                text: user?.displayName ?? "Chưa có tên",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: textGreen,
                ),
              ),
            ),
            const SizedBox(height: 15),

            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Gmail: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: user?.email ?? "Chưa có email",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildSectionBox(
              title: "Thông tin cá nhân",
              children: [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: "Sửa thông tin cá nhân",
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    );
                    if (result == true) _refresh();
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  title: "Địa chỉ nhận hàng",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddAddressScreen()),
                    );
                  },
                ),
              ],
            ),

            _buildSectionBox(
              title: "Hỗ trợ khách hàng",
              children: [
                ProfileMenuItem(
                  icon: Icons.phone_in_talk_outlined,
                  title: "Tư vấn: 0399 030 204",
                  onTap: () async {
                    final Uri url = Uri(scheme: 'tel', path: '0399030204');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Không thể mở điện thoại'),
                        ),
                      );
                    }
                  },
                ),

                ProfileMenuItem(
                  icon: Icons.error_outline,
                  title: "Khiếu nại: 0339 681 193",
                  onTap: () async {
                    final Uri url = Uri(scheme: 'tel', path: '0339681193');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Không thể mở điện thoại'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout_outlined),
                label: const Text("Đăng xuất"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: textGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LogIn()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionBox({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textGreen,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
