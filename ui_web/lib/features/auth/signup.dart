import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_web/features/auth/auth_service.dart';
import 'package:ui_web/features/auth/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập mật khẩu";
    }
    if (value.length < 8) {
      return "Mật khẩu phải có ít nhất 8 ký tự";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Mật khẩu phải có chữ thường (a-z)";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Mật khẩu phải có chữ in hoa (A-Z)";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Mật khẩu phải có số (0-9)";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Mật khẩu phải có ký tự đặc biệt (!@#...)";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập lại mật khẩu";
    }
    if (value != passwordController.text) {
      return "Mật khẩu không khớp";
    }
    return null;
  }

  Future<void> _register() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = await _authService.signUp(
        email: mailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user == null) throw Exception();

      await user.updateDisplayName(nameController.text.trim());

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LogIn()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Đăng ký thất bại";
      if (e.code == 'email-already-in-use') {
        message = "Email đã tồn tại";
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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: const Color(0xFFedf0f8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
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
                        controller: nameController,
                        hint: "Name",
                        validator: (v) =>
                            v == null || v.isEmpty ? "Nhập tên" : null,
                      ),
                      const SizedBox(height: 20),

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
                        validator: validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildInput(
                        controller: confirmPasswordController,
                        hint: "Confirm Password",
                        obscure: _obscureConfirmPassword,
                        validator: validateConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 25),

                      GestureDetector(
                        onTap: _register,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              _isLoading ? "ĐANG ĐĂNG KÝ..." : "ĐĂNG KÝ",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LogIn(),
                                ),
                              );
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.green,
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
