import 'package:flutter/material.dart';
import 'package:flutter_3d_objects/flutter_3d_objects.dart' as cube;

import 'daftar_screen.dart';
import '../services/unity_ar_launcher.dart';

class Rotation360Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final w = size.width;
    final h = size.height;

    final rect = Rect.fromLTWH(w * 0.05, h * 0.35, w * 0.9, h * 0.45);
    canvas.drawArc(rect, 0.4, 2.3, false, paint);
    canvas.drawArc(rect, 3.5, 2.3, false, paint);

    final path1 = Path();
    path1.moveTo(w * 0.85, h * 0.7);
    path1.lineTo(w * 0.95, h * 0.65);
    path1.lineTo(w * 0.88, h * 0.55);
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(w * 0.15, h * 0.48);
    path2.lineTo(w * 0.05, h * 0.52);
    path2.lineTo(w * 0.12, h * 0.62);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _isExpanded = false;

  void _onSceneCreated(cube.Scene scene, FurnitureItem item) {
    scene.camera.position.z = item.cameraZ;
    scene.camera.position.y = 0;
    scene.camera.position.x = 0;
    scene.world.add(
      cube.Object(
        fileName: item.modelAsset,
        position: cube.Vector3(0, item.positionY, 0),
        scale: cube.Vector3(item.scale, item.scale, item.scale),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item =
        (ModalRoute.of(context)?.settings.arguments as FurnitureItem?) ??
        DaftarScreen.items[0];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 380,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F6FA),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: cube.Cube(
                                key: ValueKey(item.modelAsset),
                                interactive: true,
                                zoom: true,
                                onSceneCreated: (scene) =>
                                    _onSceneCreated(scene, item),
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  item.thumbnailAsset,
                                  width: 58,
                                  height: 58,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 58,
                                      height: 58,
                                      color: Colors.white,
                                      child: const Icon(
                                        Icons.view_in_ar,
                                        color: Color(0xFF2C60C0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.touch_app_rounded,
                                      size: 16,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Drag / pinch',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned.fill(
                                      child: CustomPaint(
                                        painter: Rotation360Painter(),
                                      ),
                                    ),
                                    const Text(
                                      '360',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: _isExpanded
                                    ? item.fullDescription
                                    : item.description,
                              ),
                              if (!_isExpanded)
                                const TextSpan(
                                  text: 'Read more',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C60C0),
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
                      onTap: () =>
                          UnityArLauncher.open(context, modelId: item.id),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.view_in_ar_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Open in AR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
