import 'package:flutter/material.dart';
import '../widgets/goggles_icon.dart';
import 'details_screen.dart';

class PetunjukScreen extends StatelessWidget {
  const PetunjukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'PETUNJUK',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const GogglesIcon(size: 110),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: [
                    _buildInstructionCard(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                      title: '1. Tekan Scan Marker',
                      description:
                          'Pilih tombol "Scan" di halaman utama untuk membuka kamera',
                    ),
                    const SizedBox(height: 16),
                    _buildInstructionCard(
                      icon: const Icon(
                        Icons.visibility_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                      title: '2. Arahkan ke Marker',
                      description: 'Arahkan kamera ke gambar marker yang ada',
                    ),
                    const SizedBox(height: 16),
                    _buildInstructionCard(
                      icon: SizedBox(
                        width: 44,
                        height: 44,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: CustomPaint(painter: Rotation360Painter()),
                            ),
                            const Text(
                              '360°',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: '3. Lihat Hasil 3D',
                      description: 'Hasil 3D akan muncul di layar!',
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

  Widget _buildInstructionCard({
    required Widget icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 50, child: Center(child: icon)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFB0B0B0),
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
