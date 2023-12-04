import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
