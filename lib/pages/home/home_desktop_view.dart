import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jimanna/consts.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/routes.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeDesktopView extends ConsumerWidget {
  const HomeDesktopView({required this.isAdmin, super.key});

  final bool isAdmin;

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
        BottomAdminButton(context),
        Center(
          child: SizedBox(
            width: width * 0.95,
            height: height * 0.8,
            child: StaggeredGrid.count(
              crossAxisCount: 10,
              axisDirection: AxisDirection.down,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 10,
                  mainAxisCellCount: 1.2,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      childAspectRatio: 441 / 248,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          buildUserTextBack(),
                          buildUserText(names, index, context, width),
                        ],
                      );
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 1.7,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 441 / 248,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          buildUserTextBack(),
                          buildUserText(names, 20 + index, context, width),
                        ],
                      );
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1.8,
                  child: Center(
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
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 1.7,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 441 / 248,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          buildUserTextBack(),
                          buildUserText(names, 20 + 12 + index, context, width),
                        ],
                      );
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 10,
                  mainAxisCellCount: 2,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      childAspectRatio: 441 / 248,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          buildUserTextBack(),
                          buildUserText(names, 20 + 12 + 12 + index, context, width),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget BottomAdminButton(BuildContext context) {
    if (isAdmin) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.drawResult),
          child: Assets.images.homeDesktopBottomButton.image(
            height: 100,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Center buildUserTextBack() {
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
    return i == 24 || i == 25 || i == 34 || i == 35 || i == 44 || i == 45;
  }
}
