import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dairy_managment/screens/dashboard/admin_dashboard_screen.dart';

class FarmerLoginScreen extends StatefulWidget {
  const FarmerLoginScreen({super.key});

  @override
  State<FarmerLoginScreen> createState() => _FarmerLoginScreenState();
}

class _FarmerLoginScreenState extends State<FarmerLoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _phoneError;
  String? _passwordError;

  // Dummy credentials
  static const _validPhone = '2222222222';
  static const _validPassword = '222222';

  void _login() {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _phoneError = null;
      _passwordError = null;
    });

    bool hasError = false;

    if (phone.length != 10) {
      setState(() => _phoneError = 'Enter a valid 10-digit phone number');
      hasError = true;
    } else if (phone != _validPhone) {
      setState(() => _phoneError = 'Phone number not registered');
      hasError = true;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = 'Password cannot be empty');
      hasError = true;
    } else if (password != _validPassword) {
      setState(() => _passwordError = 'Incorrect password');
      hasError = true;
    }

    if (hasError) return;

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(userName: 'Farmer'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Top curved header ────────────────────────────────
              ClipPath(
                clipper: _CurvedClipper(),
                child: Container(
                  width: double.infinity,
                  height: 260,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B5E38), Color(0xFF2D9A5B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative circles
                      Positioned(
                        top: -30,
                        right: -30,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.06),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                      // Back button
                      Positioned(
                        top: 16,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      // Center content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.agriculture_outlined,
                                color: Colors.white,
                                size: 42,
                              ),
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'Farmer Portal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Welcome to your dairy account',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Form area ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 32, 28, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D9A5B),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1B3A28),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Phone field
                    _buildLabel('Mobile Number'),
                    const SizedBox(height: 8),
                    _FarmerTextField(
                      controller: _phoneController,
                      hint: 'Enter 10-digit number',
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      prefixIcon: Icons.smartphone_outlined,
                      errorText: _phoneError,
                    ),

                    const SizedBox(height: 20),

                    // Password field
                    _buildLabel('Password'),
                    const SizedBox(height: 8),
                    _FarmerTextField(
                      controller: _passwordController,
                      hint: 'Enter your password',
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF2D9A5B),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(
                              () => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      errorText: _passwordError,
                    ),

                    const SizedBox(height: 36),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E38),
                          disabledBackgroundColor:
                              const Color(0xFF1B5E38).withValues(alpha: 0.5),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Divider with hint
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D9A5B).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF2D9A5B).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 16,
                            color: const Color(0xFF2D9A5B).withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Demo: Phone 2222222222 · Password 222222',
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF1B3A28).withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2D4A35),
        letterSpacing: 0.3,
      ),
    );
  }
}

class _FarmerTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? errorText;

  const _FarmerTextField({
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.inputFormatters,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: errorText != null
                  ? Colors.redAccent
                  : const Color(0xFFD4E8DA),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2D9A5B).withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            style: const TextStyle(
              color: Color(0xFF1B3A28),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color(0xFF1B3A28).withValues(alpha: 0.3),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: const Color(0xFF2D9A5B),
                size: 20,
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}

// Curved bottom clipper for header
class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}