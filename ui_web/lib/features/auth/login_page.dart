import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/auth/auth_service.dart';
import 'package:ui_web/features/auth/signup.dart';
import 'package:ui_web/navigation/bottom_nav_bar.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await _authService.signIn(
        email: mailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavigation()),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(e.message ?? "Đã có lỗi xảy ra");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -50,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: accentGreen.withOpacity(0.3),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/login.png",
                          height: 120,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    const Text(
                      "Đăng Nhập",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Khám phá thực phẩm hữu cơ cho gia đình bạn",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    _buildCustomTextField(
                      controller: mailController,
                      hint: "Địa chỉ Email",
                      icon: Icons.alternate_email_rounded,
                      validator: (v) =>
                          v!.isEmpty ? "Vui lòng nhập email" : null,
                    ),
                    const SizedBox(height: 20),

                    _buildCustomTextField(
                      controller: passwordController,
                      hint: "Mật khẩu",
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      obscure: _obscurePassword,
                      toggleObscure: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      validator: (v) =>
                          v!.isEmpty ? "Vui lòng nhập mật khẩu" : null,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Quên mật khẩu?",
                          style: TextStyle(
                            color: primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    GestureDetector(
                      onTap: _login,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [primaryGreen, const Color(0xFF43A047)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryGreen.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Bắt đầu mua sắm",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUp()),
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: "Bạn mới biết đến chúng tôi? ",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: "Đăng ký",
                                style: TextStyle(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? toggleObscure,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
        prefixIcon: Icon(icon, color: primaryGreen, size: 22),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: Colors.grey,
                ),
                onPressed: toggleObscure,
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFF1F8E9),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: primaryGreen.withOpacity(0.5),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
