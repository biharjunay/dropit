import 'package:flutter/material.dart';
import '../services/unity_ar_launcher.dart';
import '../widgets/custom_waves.dart';
import '../widgets/goggles_icon.dart';
import '../widgets/gradient_text.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final bottomGap = screenHeight < 700 ? 70.0 : 120.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: TopWaveClipper(),
              child: Container(
                height: 180,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C63C5), Color(0xFF42A6E9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                width: 200,
                height: 350,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF67B0E8), Color(0xFF3886DF)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'DROP ',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2856B2),
                        letterSpacing: 1.5,
                      ),
                    ),
                    GradientText(
                      'IT',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1FC3C9), Color(0xFF3CE39F)],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const GogglesIcon(size: 110),
                const Spacer(),
                _buildMenuButton(
                  context,
                  icon: Icons.camera_alt_outlined,
                  label: 'Scan',
                  onPressed: () => UnityArLauncher.open(context),
                ),
                const SizedBox(height: 16),
                _buildMenuButton(
                  context,
                  icon: Icons.list_alt_rounded,
                  label: 'Daftar',
                  onPressed: () {
                    Navigator.pushNamed(context, '/daftar');
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuButton(
                  context,
                  icon: Icons.person_outline_rounded,
                  label: 'Petunjuk',
                  onPressed: () {
                    Navigator.pushNamed(context, '/petunjuk');
                  },
                ),
                SizedBox(height: bottomGap),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 250,
      height: 55,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2C60C0), Color(0xFF2E5CB8)],
        ),
        borderRadius: BorderRadius.circular(27.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C60C0).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(27.5),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
