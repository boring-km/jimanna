import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/providers/name_register_provider.dart';

class HomeDesktopView extends ConsumerWidget {
  const HomeDesktopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final names = ref.watch(currentRegisteredNamesProvider);

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
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
          child: GridView.builder(
            itemCount: names.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Center(
                    child: Assets.images.nameBackground.image(
                      width: 150
                    ),
                  ),
                  Center(
                    child: Text(
                      names[index],
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                    ),
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
