import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      final user = await _authService.signIn(
        email: mailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user == null) throw Exception();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavigation()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Sai email hoặc mật khẩu";

      if (e.code == 'user-not-found') {
        message = "Không tìm thấy tài khoản";
      } else if (e.code == 'wrong-password') {
        message = "Mật khẩu không đúng";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
      decoration: BoxDecoration(
        color: const Color(0xFFedf0f8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Image.asset(
                "assets/images/login.png",
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              flex: 4,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildInput(
                        controller: mailController,
                        hint: "Email",
                        validator: (v) =>
                            v == null || v.isEmpty ? "Nhập email" : null,
                      ),
                      const SizedBox(height: 20),

                      _buildInput(
                        controller: passwordController,
                        hint: "Password",
                        obscure: _obscurePassword,
                        validator: (v) =>
                            v == null || v.isEmpty ? "Nhập mật khẩu" : null,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                      GestureDetector(
                        onTap: _login,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 55, 189, 55),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              _isLoading ? "ĐANG ĐĂNG NHẬP..." : "ĐĂNG NHẬP",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUp(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color.fromARGB(255, 55, 189, 55),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
