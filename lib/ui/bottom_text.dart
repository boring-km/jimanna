import 'package:flutter/material.dart';
import 'package:jimanna/gen/assets.gen.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: height / 70),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Assets.images.youngPeace.image(height: 30),
      ),
    );
  }
}
