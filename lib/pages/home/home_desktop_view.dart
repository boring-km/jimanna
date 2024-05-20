import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jimanna/consts.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/providers/is_start_draw_provider.dart';
import 'package:jimanna/ui/ongmezim_text.dart';
import 'package:jimanna/utils/background_audio_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeDesktopView extends ConsumerStatefulWidget {
  const HomeDesktopView({required this.isAdmin, super.key});

  final bool isAdmin;

  @override
  ConsumerState<HomeDesktopView> createState() => _HomeDesktopViewState();
}

class _HomeDesktopViewState extends ConsumerState<HomeDesktopView> {

  @override
  void initState() {
    setAudioPlayer();
    super.initState();
  }

  void setAudioPlayer() {
    audioPlayer.setLoopMode(LoopMode.all);
    audioPlayer
        .setAsset(
      'assets/music/background_music.mp3',
      initialPosition: const Duration(seconds: 15),
    )
        .then(
          (value) =>
          Future.delayed(const Duration(seconds: 1), audioPlayer.play),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final names = ref.watch(currentRegisteredNamesProvider)..shuffle(Random());

    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Assets.images.homeDesktopBackground.image(
                height: height,
                fit: BoxFit.fitHeight,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Assets.images.homeDesktopTop.image(
            height: 70,
          ),
        ),
        BottomText(context, width, height),
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
                  mainAxisCellCount: 1.8,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      childAspectRatio: 441 / 248,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 30,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 441 / 248,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 16,
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
                    itemCount: 16,
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
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          buildUserTextBack(),
                          buildUserText(
                            names,
                            20 + 12 + 12 + index,
                            context,
                            width,
                          ),
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

  Align BottomGround(double height, double width) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: height * 0.2,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Assets.images.homeDesktopBottom.image(
              width: width / 2,
              height: height * 0.2,
              alignment: Alignment.bottomCenter,
            );
          },
        ),
      ),
    );
  }

  Widget BottomText(BuildContext context, double width, double height) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: height * 0.05,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ongmezimText(context, width / 2),
        ),
      ),
    );
  }

  Widget BottomAdminButton(BuildContext context, WidgetRef ref, double height) {
    if (widget.isAdmin) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            ref.read(adminDrawProvider.notifier).makeTeams();
            ref.read(isStartDrawProvider.notifier).startDraw();
          },
          child: Assets.images.homeDesktopBottomButton.image(
            height: height * 0.05,
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
    List<Name> names,
    int index,
    BuildContext context,
    double width,
  ) {
    if (names.length <= index) {
      return const Center();
    }
    return Center(
      child: Text(
        '${names[index].type}: ${names[index].name}',
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
