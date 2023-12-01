import 'package:flutter/material.dart';

final textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.w800,
    shadows: shadows(),
  ),
  displayMedium: TextStyle(
    fontSize: 55,
    fontWeight: FontWeight.w800,
    shadows: shadows(),
  ),
  displaySmall: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    shadows: smallShadows(),
  ),
);

List<Shadow> shadows() {
  return [
    const Shadow(
      offset: Offset(0, -5),
    ),
    const Shadow(
      offset: Offset(-5, 0),
    ),
    const Shadow(
      offset: Offset(5, 0),
    ),
    const Shadow(
      offset: Offset(0, 5),
    ),
    const Shadow(
      offset: Offset(-3, -3),
    ),
    const Shadow(
      offset: Offset(3, -3),
    ),
    const Shadow(
      offset: Offset(-3, 3),
    ),
    const Shadow(
      offset: Offset(6, 6),
    ),
  ];
}

// small shadows
List<Shadow> smallShadows() {
  return [
    const Shadow(
      offset: Offset(2, 0),
    ),
    const Shadow(
      offset: Offset(0, 2),
    ),
    const Shadow(
      offset: Offset(0, -2),
    ),
    const Shadow(
      offset: Offset(-2, 0),
    ),
    const Shadow(
      offset: Offset(-2, 2),
    ),
    const Shadow(
      offset: Offset(2, -2),
    ),
    const Shadow(
      offset: Offset(-2, -2),
    ),
    const Shadow(
      offset: Offset(2, 2),
    ),
  ];
}

final textOutline = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 0.5
  ..color = Colors.black;
