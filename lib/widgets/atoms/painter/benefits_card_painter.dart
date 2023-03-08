import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class BenefitsCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = ColorsTheme.secondaryBlue;
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;

    final path = Path();
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BenefitsCardPainter oldDelegate) => false;
}
