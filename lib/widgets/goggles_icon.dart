import 'package:flutter/material.dart';

class GogglesPainter extends CustomPainter {
  final Color notchColor;

  GogglesPainter({required this.notchColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;
    final r = h * 0.35;

    path.moveTo(r, h * 0.15);
    path.lineTo(w - r, h * 0.15);
    path.quadraticBezierTo(w, h * 0.15, w, h * 0.15 + r);
    path.lineTo(w, h * 0.85 - r);
    path.quadraticBezierTo(w, h * 0.85, w - r, h * 0.85);
    path.lineTo(w * 0.65, h * 0.85);
    path.quadraticBezierTo(w * 0.5, h * 0.55, w * 0.35, h * 0.85);
    path.lineTo(r, h * 0.85);
    path.quadraticBezierTo(0, h * 0.85, 0, h * 0.85 - r);
    path.lineTo(0, h * 0.15 + r);
    path.quadraticBezierTo(0, h * 0.15, r, h * 0.15);
    path.close();
    canvas.drawPath(path, paint);

    final notchPaint = Paint()
      ..color = notchColor
      ..style = PaintingStyle.fill;

    final notchRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.38, w * 0.28, w * 0.24, h * 0.12),
      Radius.circular(h * 0.06),
    );
    canvas.drawRRect(notchRect, notchPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GogglesIcon extends StatelessWidget {
  final double size;
  final Color backgroundColor;

  const GogglesIcon({
    super.key,
    this.size = 100.0,
    this.backgroundColor = const Color(0xFF2D5CBA),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          width: size * 0.55,
          height: size * 0.55,
          child: CustomPaint(
            painter: GogglesPainter(notchColor: backgroundColor),
          ),
        ),
      ),
    );
  }
}
