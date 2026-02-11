import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dairy_managment/screens/dashboard/admin_dashboard_screen.dart';

class SecretaryLoginScreen extends StatefulWidget {
  const SecretaryLoginScreen({super.key});

  @override
  State<SecretaryLoginScreen> createState() => _SecretaryLoginScreenState();
}

class _SecretaryLoginScreenState extends State<SecretaryLoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  bool _isLoading = false;
  String? _phoneError;
  String? _otpError;

  // Dummy credentials
  static const _validPhone = '1111111111';
  static const _validOtp = '111111';

  void _sendOtp() {
    final phone = _phoneController.text.trim();
    setState(() => _phoneError = null);

    if (phone.length != 10) {
      setState(() => _phoneError = 'Enter a valid 10-digit phone number');
      return;
    }
    if (phone != _validPhone) {
      setState(() => _phoneError = 'Phone number not registered');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _otpSent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('OTP sent: 111111'),
            backgroundColor: const Color(0xFF4A90D9),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    });
  }

  void _verifyOtp() {
    final otp = _otpController.text.trim();
    setState(() => _otpError = null);

    if (otp.length != 6) {
      setState(() => _otpError = 'Enter the 6-digit OTP');
      return;
    }
    if (otp != _validOtp) {
      setState(() => _otpError = 'Incorrect OTP. Please try again');
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(userName: 'Secretary'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1B35),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Top illustration area ─────────────────────────────
              Container(
                width: double.infinity,
                height: 240,
                decoration: const BoxDecoration(
                  color: Color(0xFF1B2B4B),
                ),
                child: Stack(
                  children: [
                    // Grid pattern
                    Positioned.fill(
                      child: CustomPaint(painter: _GridPainter()),
                    ),
                    // Glowing circle
                    Center(
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF4A90D9).withValues(alpha: 0.15),
                          border: Border.all(
                            color: const Color(0xFF4A90D9).withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4A90D9).withValues(alpha: 0.25),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.admin_panel_settings_outlined,
                          color: Color(0xFF4A90D9),
                          size: 48,
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
                            color: Colors.white.withValues(alpha: 0.08),
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
                  ],
                ),
              ),

              // ── Form area ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 36, 28, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Secretary Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                        letterSpacing: -0.8,
                      ),
                    ),
                   

                    const SizedBox(height: 40),

                    // Phone field
                    _buildLabel('Phone Number'),
                    const SizedBox(height: 8),
                    _SecretaryTextField(
                      controller: _phoneController,
                      hint: '10-digit mobile number',
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      prefixIcon: Icons.phone_outlined,
                      enabled: !_otpSent,
                      errorText: _phoneError,
                    ),

                    if (_otpSent) ...[
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLabel('Enter OTP'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _otpSent = false;
                                _otpController.clear();
                                _otpError = null;
                              });
                            },
                            child: const Text(
                              'Change number?',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF4A90D9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _SecretaryTextField(
                        controller: _otpController,
                        hint: '6-digit OTP',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        prefixIcon: Icons.lock_outline_rounded,
                        errorText: _otpError,
                      ),
                    ],

                    const SizedBox(height: 36),

                    // Action button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : (_otpSent ? _verifyOtp : _sendOtp),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90D9),
                          disabledBackgroundColor:
                              const Color(0xFF4A90D9).withValues(alpha: 0.5),
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
                            : Text(
                                _otpSent ? 'Verify & Login' : 'Send OTP',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Demo: Phone 1111111111 · OTP 111111',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
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
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white.withValues(alpha: 0.6),
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SecretaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final IconData prefixIcon;
  final bool enabled;
  final String? errorText;

  const _SecretaryTextField({
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.inputFormatters,
    required this.prefixIcon,
    this.enabled = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1B2B4B),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: errorText != null
                  ? Colors.redAccent
                  : enabled
                      ? const Color(0xFF2E4270)
                      : const Color(0xFF4A90D9).withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            enabled: enabled,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.25),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: enabled
                    ? const Color(0xFF4A90D9)
                    : Colors.white.withValues(alpha: 0.3),
                size: 20,
              ),
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

// Grid background painter
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A90D9).withValues(alpha: 0.07)
      ..strokeWidth = 1;
    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}