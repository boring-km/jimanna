import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height / 70),
      child: Text(
        '아바드',
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
