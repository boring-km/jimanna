import 'package:flutter/material.dart';

Widget ongmezimText(BuildContext context, double width) {
  return Text(
    'Designed by ongmezim',
    textAlign: TextAlign.right,
    style: Theme.of(context)
        .textTheme
        .displaySmall
        ?.copyWith(
      color: Colors.white,
      fontSize: width / 35,
    ),
  );
}
