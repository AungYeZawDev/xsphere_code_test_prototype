import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color(0xFF512f7f)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint0.shader = ui.Gradient.linear(
        Offset(size.width, 0),
        Offset(size.width, size.height),
        [const Color(0xFF512f7f), const Color(0xffffffff)],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
