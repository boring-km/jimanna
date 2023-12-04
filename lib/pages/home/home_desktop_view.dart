import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/consts.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/providers/name_register_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeDesktopView extends ConsumerWidget {
  const HomeDesktopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final names = ref.watch(currentRegisteredNamesProvider);
    final convertedNames = convertNames(names);

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
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: height / 20),
            child: SizedBox(
              width: width * 0.95,
              height: height * 0.7,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  crossAxisSpacing: 30,
                  childAspectRatio: 441 / (248 + 60),
                ),
                itemCount: 70,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      buildUserTextBack(index),
                      buildUserText(convertedNames, index, context, width),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: height / 20),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  width: width / 7,
                  height: width / 7,
                ),
                QrImageView(data: homeUrl, size: width / 7),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Center buildUserTextBack(int index) {
    return Center(child: Assets.images.nameBackground.image());
  }

  Center buildUserText(
      List<String> names, int index, BuildContext context, double width) {
    if (names.length <= index) {
      return const Center();
    }
    return Center(
      child: Text(
        names[index],
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontSize: width / 70,
            ),
      ),
    );
  }

  List<String> convertNames(List<String> names) {
    final convertedNames = List<String>.filled(70, '');
    var count = 0;
    for (var i = 0; i < names.length; i++) {
      if (isHiddenIndex(i)) {
        convertedNames[69 - count] = names[i];
        count++;
      } else {
        convertedNames[i] = names[i];
      }
    }
    return convertedNames;
  }

  bool isHiddenIndex(int i) {
    return i == 24 ||
        i == 25 ||
        i == 34 ||
        i == 35 ||
        i == 44 ||
        i == 45;
  }
}
