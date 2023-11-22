import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    // 배경 색은 185ABD
    // 일정한 간격으로 전체 화면에 동그란 원을 그린다. 색은 3173D6
    // 원의 크기는 5으로 그린다.
    // 원의 간격은 30으로 그린다.
    final paint = Paint()
      ..color = const Color(0xFF185ABD)
      ..style = PaintingStyle.fill;

    final circlePaint = Paint()
      ..color = const Color(0xFF3173D6)
      ..style = PaintingStyle.fill;

    const circleRadius = 1.5;
    const circleGap = 20.0;


    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    for (var i = 0; i < size.width / circleGap; i++) {
      for (var j = 0; j < size.height / circleGap; j++) {
        canvas.drawCircle(
          Offset(i * circleGap, j * circleGap),
          circleRadius,
          circlePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;
}

