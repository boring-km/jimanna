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
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(-5, 0),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(5, 0),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(0, 5),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(-3, -3),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(3, -3),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(-3, 3),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(6, 6),
      color: Colors.black,
    ),
  ];
}

// small shadows
List<Shadow> smallShadows() {
  return [
    const Shadow(
      offset: Offset(2, 0),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(0, 2),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(0, -2),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(-2, 0),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(-2, 2),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(2, -2),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(-2, -2),
      color: Colors.black,
    ),
    const Shadow(
      offset: Offset(2, 2),
      color: Colors.black,
    ),
  ];
}

final textOutline = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 0.5
  ..color = Colors.black;
