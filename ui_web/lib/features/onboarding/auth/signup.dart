import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_web/features/onboarding/auth/auth_service.dart';
import 'package:ui_web/features/onboarding/auth/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

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
      await user.reload();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LogIn()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Đăng ký thất bại";

      if (e.code == 'weak-password') {
        message = "Mật khẩu quá yếu";
      } else if (e.code == 'email-already-in-use') {
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
          hintStyle: const TextStyle(color: Color(0xFFb2b7bf), fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/login.png", fit: BoxFit.cover),
            const SizedBox(height: 17),

            Padding(
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

                    const SizedBox(height: 25),

                    _buildInput(
                      controller: mailController,
                      hint: "Email",
                      validator: (v) =>
                          v == null || v.isEmpty ? "Nhập email" : null,
                    ),

                    const SizedBox(height: 30),

                    _buildInput(
                      controller: passwordController,
                      hint: "Password",
                      obscure: true,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Nhập mật khẩu" : null,
                    ),

                    const SizedBox(height: 25),

                    GestureDetector(
                      onTap: _register,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 55, 189, 55),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            _isLoading ? "Signing up..." : "Sign Up",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LogIn()),
                    );
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 55, 189, 55),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
