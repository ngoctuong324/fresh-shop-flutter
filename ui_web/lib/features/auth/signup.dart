import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
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
    if (value == null || value.isEmpty) return "Vui lòng nhập mật khẩu";
    if (value.length < 8) return "Mật khẩu phải có ít nhất 8 ký tự";
    if (!RegExp(r'[a-z]').hasMatch(value))
      return "Mật khẩu phải có chữ thường (a-z)";
    if (!RegExp(r'[A-Z]').hasMatch(value))
      return "Mật khẩu phải có chữ in hoa (A-Z)";
    if (!RegExp(r'[0-9]').hasMatch(value)) return "Mật khẩu phải có số (0-9)";
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value))
      return "Mật khẩu phải có ký tự đặc biệt (!@#...)";
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return "Vui lòng nhập lại mật khẩu";
    if (value != passwordController.text) return "Mật khẩu không khớp";
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
      String message = e.code == 'email-already-in-use'
          ? "Email đã tồn tại"
          : "Đăng ký thất bại";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -60,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: accentGreen.withOpacity(0.3),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Đăng Ký",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    Text(
                      "Tạo tài khoản để trải nghiệm thực phẩm sạch",
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 30),

                    _buildModernInput(
                      controller: nameController,
                      hint: "Họ và tên",
                      icon: Icons.person_outline_rounded,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Nhập tên" : null,
                    ),
                    const SizedBox(height: 15),

                    _buildModernInput(
                      controller: mailController,
                      hint: "Email",
                      icon: Icons.email_outlined,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Nhập email" : null,
                    ),
                    const SizedBox(height: 15),

                    _buildModernInput(
                      controller: passwordController,
                      hint: "Mật khẩu",
                      icon: Icons.lock_outline_rounded,
                      obscure: _obscurePassword,
                      validator: validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    _buildModernInput(
                      controller: confirmPasswordController,
                      hint: "Xác nhận mật khẩu",
                      icon: Icons.lock_reset_rounded,
                      obscure: _obscureConfirmPassword,
                      validator: validateConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: primaryGreen.withOpacity(0.4),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "TẠO TÀI KHOẢN",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Đã có tài khoản? ",
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const LogIn()),
                            ),
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(
                                color: primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
        prefixIcon: Icon(icon, color: primaryGreen, size: 22),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF1F8E9),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: primaryGreen.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        errorStyle: const TextStyle(height: 1),
      ),
    );
  }
}
