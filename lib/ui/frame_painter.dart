import 'package:flutter/material.dart';

class FramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rectPaint = Paint()
      ..color = const Color(0xFF185ABD)
      ..style = PaintingStyle.fill;

    final rectShadowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final rect = Rect.fromLTWH(30, 20, size.width - 60, size.height - 30);
    final rectPath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(20)));

    final shadowRect1 =
        Rect.fromLTWH(30, 20, size.width - 60, size.height - 30);
    final shadowPath1 = Path()
      ..addRRect(
          RRect.fromRectAndRadius(shadowRect1, const Radius.circular(20)));

    final shadowRect2 =
        Rect.fromLTWH(33, 23, size.width - 60, size.height - 30);
    final shadowPath2 = Path()
      ..addRRect(
          RRect.fromRectAndRadius(shadowRect2, const Radius.circular(20)));

    final shadowRect3 =
        Rect.fromLTWH(33, 20, size.width - 60, size.height - 30);
    final shadowPath3 = Path()
      ..addRRect(
          RRect.fromRectAndRadius(shadowRect3, const Radius.circular(20)));

    final shadowRect4 =
        Rect.fromLTWH(30, 23, size.width - 60, size.height - 30);
    final shadowPath4 = Path()
      ..addRRect(
          RRect.fromRectAndRadius(shadowRect4, const Radius.circular(20)));

    canvas.drawPath(shadowPath1, rectShadowPaint);
    canvas.drawPath(shadowPath2, rectShadowPaint);
    canvas.drawPath(shadowPath3, rectShadowPaint);
    canvas.drawPath(shadowPath4, rectShadowPaint);

    canvas.drawPath(rectPath, rectPaint);
  }

  @override
  bool shouldRepaint(FramePainter oldDelegate) => false;
}
