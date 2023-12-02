import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';

class HomeDesktopView extends ConsumerWidget {
  const HomeDesktopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Assets.images.homeDesktopBackground.image(
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Assets.images.homeDesktopTop.image(
            height: 70,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Assets.images.homeDesktopBottom.image(
            width: width,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Assets.images.homeDesktopBottomButton.image(
            height: 100,
          ),
        ),
      ],
    );
  }
}
