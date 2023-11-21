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

    // 세로가 긴 사각형을 그리는데 모서리가 둥글고, 오른쪽 아래로 그림자가 표현되듯이 그려져야 한다.
    // 사각형의 색은 185ABD
    // 사각형의 그림자 색은 black
    // 사각형의 그림자 offset은 Offset(5, 5)
    // 사각형의 그림자 blurRadius는 5

    final rectPaint = Paint()
      ..color = const Color(0xFF185ABD)
      ..style = PaintingStyle.fill;

    final rectShadowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final rect = Rect.fromLTWH(30, 20, size.width - 60, size.height - 80);
    final rectPath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(20)));

    final shadowRect1 = Rect.fromLTWH(30, 20, size.width - 60, size.height - 80);
    final shadowPath1 = Path()
      ..addRRect(RRect.fromRectAndRadius(shadowRect1, const Radius.circular(20)));

    final shadowRect2 = Rect.fromLTWH(33, 23, size.width - 60, size.height - 80);
    final shadowPath2 = Path()
      ..addRRect(RRect.fromRectAndRadius(shadowRect2, const Radius.circular(20)));

    final shadowRect3 = Rect.fromLTWH(33, 20, size.width - 60, size.height - 80);
    final shadowPath3 = Path()
      ..addRRect(RRect.fromRectAndRadius(shadowRect3, const Radius.circular(20)));

    final shadowRect4 = Rect.fromLTWH(30, 23, size.width - 60, size.height - 80);
    final shadowPath4 = Path()
      ..addRRect(RRect.fromRectAndRadius(shadowRect4, const Radius.circular(20)));

    canvas.drawPath(shadowPath1, rectShadowPaint);
    canvas.drawPath(shadowPath2, rectShadowPaint);
    canvas.drawPath(shadowPath3, rectShadowPaint);
    canvas.drawPath(shadowPath4, rectShadowPaint);

    canvas.drawPath(rectPath, rectPaint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => false;
}
