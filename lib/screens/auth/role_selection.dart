import 'package:flutter/material.dart';
import 'secretary_login_screen.dart';
import 'farmer_login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top logo / branding
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D6A4F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.water_drop_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Dairy',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A3C2B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),

              
              const SizedBox(height: 48),

              // Farmer Card
              _RoleCard(
                title: 'Farmer',
                subtitle: 'Access your milk records\nand account details',
                icon: Icons.agriculture_outlined,
                backgroundColor: const Color(0xFF2D6A4F),
                accentColor: const Color(0xFF52B788),
                tagColor: const Color(0xFF52B788).withValues(alpha: 0.2),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FarmerLoginScreen(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Secretary Card
              _RoleCard(
                title: 'Secretary',
                subtitle: 'Manage collections,\nreports & farmer data',
                icon: Icons.admin_panel_settings_outlined,
                backgroundColor: const Color(0xFF1B2B4B),
                accentColor: const Color(0xFF4A90D9),
                tagColor: const Color(0xFF4A90D9).withValues(alpha: 0.2),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SecretaryLoginScreen(),
                  ),
                ),
              ),

              const Spacer(),

              // Footer
              Center(
                child: Text(
                  'Dairy Management System v1.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF1A3C2B).withValues(alpha: 0.35),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color accentColor;
  final Color tagColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.accentColor,
    required this.tagColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // Icon bubble
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 20),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.65),
                        height: 1.4,
                      ),
                    ),
                    // const SizedBox(height: 12),
                    
                  ],
                ),
              ),

              // Arrow
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}