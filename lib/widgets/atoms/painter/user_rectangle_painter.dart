import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class UserRectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = ColorsTheme.secondaryBlue;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.fill;

    final a = Offset(size.width * 0, size.height * 0);
    final b = Offset(size.width, size.height * 0.25);
    final c = Offset(size.width * 0, size.height * 0.2);
    final d = Offset(size.width, size.height * 0.25);
    final rect1 = Rect.fromPoints(a, b);
    final rect2 = Rect.fromPoints(c, d);
    const radius = Radius.circular(8.0);

    canvas.drawRRect(RRect.fromRectAndRadius(rect1, radius), paint);
    canvas.drawRect(rect2, paint);
  }

  @override
  bool shouldRepaint(UserRectanglePainter oldDelegate) => false;
}
