import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomFanIcon extends StatelessWidget {
  final double size;
  final Color color;
  final Animation<double> animation;

  const CustomFanIcon({
    super.key,
    required this.size,
    required this.color,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value * 2 * 3.14159,
          child: CustomPaint(
            size: Size(size, size),
            painter: FanPainter(color: color),
          ),
        );
      },
    );
  }
}

class FanPainter extends CustomPainter {
  final Color color;

  FanPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw center circle
    canvas.drawCircle(center, radius * 0.15, paint);

    // Draw fan blades (4 blades)
    for (int i = 0; i < 4; i++) {
      final angle = (i * 90) * (3.14159 / 180); // Convert to radians

      // Calculate blade path
      final path = Path();

      // Start from center
      final startX = center.dx + (radius * 0.15) * cos(angle);
      final startY = center.dy + (radius * 0.15) * sin(angle);

      // Blade tip
      final tipX = center.dx + (radius * 0.85) * cos(angle);
      final tipY = center.dy + (radius * 0.85) * sin(angle);

      // Blade sides
      final sideAngle1 = angle + (25 * 3.14159 / 180);
      final sideAngle2 = angle - (25 * 3.14159 / 180);

      final side1X = center.dx + (radius * 0.7) * cos(sideAngle1);
      final side1Y = center.dy + (radius * 0.7) * sin(sideAngle1);

      final side2X = center.dx + (radius * 0.7) * cos(sideAngle2);
      final side2Y = center.dy + (radius * 0.7) * sin(sideAngle2);

      // Create blade shape
      path.moveTo(startX, startY);
      path.lineTo(side1X, side1Y);
      path.quadraticBezierTo(tipX, tipY, side2X, side2Y);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Helper functions for trigonometry
double cos(double angle) => math.cos(angle);
double sin(double angle) => math.sin(angle);
