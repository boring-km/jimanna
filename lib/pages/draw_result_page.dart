import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/gen/colors.gen.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/providers/current_name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/routes.dart';
import 'package:jimanna/ui/background_painter.dart';
import 'package:jimanna/ui/ongmezim_text.dart';
import 'package:jimanna/ui/themes.dart';
import 'package:jimanna/utils/background_audio_player.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

class DrawResultPage extends ConsumerStatefulWidget {
  const DrawResultPage({required this.isMobile, super.key});

  final bool isMobile;

  @override
  ConsumerState<DrawResultPage> createState() => _DrawResultPageState();
}

class _DrawResultPageState extends ConsumerState<DrawResultPage> {
  late final bool isMobileState;
  final counter = ValueNotifier(10);
  final showResult = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    isMobileState = widget.isMobile;
    _controller = VideoPlayerController.asset(Assets.videos.introVideo5s);

    if (isMobileState) {
      setMobileViewData();
    } else {
      setVideoPlayer();
    }
    //
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   moveIfDrawEnd(context);
    // });
  }

  void setVideoPlayer() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.initialize().then((_) {
        setState(() {
          _controller.play().then((_) {
            _controller.setLooping(true);
            startResultTimer();
          });
          // setAudioPlayer();
        });
      });
    });
  }

  void setAudioPlayer() {
    audioPlayer.stop().then((_) => audioPlayer.play());
  }

  void startResultTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      counter.value--;
      if (counter.value == 0) {
        timer.cancel();
        _controller.pause();
        showResult.value = true;
        // TODO showNamesWithTimer();
      }
    });
  }

  final teamCount = ValueNotifier(1);
  final firstName = ValueNotifier('');
  final secondName = ValueNotifier('');
  final thirdName = ValueNotifier('');
  final fourthName = ValueNotifier('');
  final fifthName = ValueNotifier('');
  final sixthName = ValueNotifier('');
  final seventhName = ValueNotifier('');

  final myNameTeamNumber = ValueNotifier(0);

  int findMyNameTeamNumber() {
    final teamDraw = ref.read(adminDrawProvider);
    for (var j = 0; j < teamDraw.teams.length; j++) {
      for (var i = 0; i < teamDraw.teams[j].names.length; i++) {
        if (teamDraw.teams[j].names[i] == CurrentName.value) {
          return j + 1;
        }
      }
    }
    return 0;
  }

  Future<void> showNamesWithTimer() async {
    final teamDraw = ref.read(adminDrawProvider);
    for (var teamIndex = 0; teamIndex < teamDraw.teams.length; teamIndex++) {
      final team = teamDraw.teams[teamIndex];
      await Future.delayed(const Duration(milliseconds: 1000));
      await showNames(team);
      ref.read(adminOptionsProvider.notifier).updateTeamNumber(teamIndex + 1);
      await Future.delayed(const Duration(seconds: 4));
      if (teamIndex < teamDraw.teams.length - 1) {
        teamCount.value++;
      }
      clearNames();
    }
    ref.read(adminOptionsProvider.notifier).endDraw();
    unawaited(Navigator.popAndPushNamed(context, Routes.drawTotalResultPage));
  }

  Future<void> showNames(Team team) async {
    for (var i = 0; i < team.names.length; i++) {
      if (i == 0) {
        firstName.value = team.names[i].name;
        await Future.delayed(const Duration(milliseconds: 300));
      } else if (i == 1) {
        secondName.value = team.names[i].name;
        await Future.delayed(const Duration(milliseconds: 300));
      } else if (i == 2) {
        thirdName.value = team.names[i].name;
        await Future.delayed(const Duration(milliseconds: 300));
      } else if (i == 3) {
        fourthName.value = team.names[i].name;
        await Future.delayed(const Duration(milliseconds: 300));
      } else if (i == 4) {
        fifthName.value = team.names[i].name;
        await Future.delayed(const Duration(milliseconds: 300));
      } else if (i == 5) {
        sixthName.value = team.names[i].name;
        await Future.delayed(const Duration(milliseconds: 300));
      } else if (i == 6) {
        seventhName.value = team.names[i].name;
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  void clearNames() {
    firstName.value = '';
    secondName.value = '';
    thirdName.value = '';
    fourthName.value = '';
    fifthName.value = '';
    sixthName.value = '';
    seventhName.value = '';
  }

  late VideoPlayerController _controller;
  final nintendoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // ref
    //   ..read(adminOptionsProvider.notifier)
    //   ..read(adminDrawProvider);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isMobile = width < 787 || height < 787;

    final nintendoHeight = getNintendoHeight();

    return isMobile
        ? MobileView(width)
        : DesktopView(width, height, nintendoHeight);
  }

  void moveIfDrawEnd(BuildContext context) {
    final isDrawEnd = ModalRoute.of(context)!.settings.arguments! as bool;
    if (isDrawEnd) {
      myNameTeamNumber.value = findMyNameTeamNumber();
      if (!isMobileState) {
        unawaited(
          Navigator.pushReplacementNamed(
            context,
            Routes.drawTotalResultPage,
          ),
        );
      }
    }
  }

  Widget DesktopView(double width, double height, double nintendoHeight) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Assets.images.drawBackground.image(
              width: width,
              height: height,
              fit: BoxFit.fitHeight,
            ),
          ),
          BottomText(context, width * (3 / 4), height),
          ReadyVideoView(width, nintendoHeight),
          MainView(height),
        ],
      ),
    );
  }

  ValueListenableBuilder<bool> ReadyVideoView(
      double width, double nintendoHeight) {
    return ValueListenableBuilder(
      valueListenable: showResult,
      builder: (context, value, child) {
        if (value) return const SizedBox.shrink();
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: Assets.images.nintendo.image(
                  key: nintendoKey,
                  width: width * 0.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: _controller.value.isInitialized
                    ? SizedBox(
                        width: nintendoHeight * (16 / 9),
                        height: nintendoHeight,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : Container(),
              ),
            ),
          ],
        );
      },
    );
  }

  final wr = 1920 / 3527;
  final hr = 1080 / 1984;

  ValueListenableBuilder<bool> MainView(double height) {
    return ValueListenableBuilder(
      valueListenable: showResult,
      builder: (context, value, child) {
        if (!value) return const SizedBox.shrink();
        return Stack(
          children: [
            TopTextView(height, context),
            Characters(),
            Bubbles(),
          ],
        );
      },
    );
  }

  Stack Bubbles() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 30 * wr, bottom: 892 * hr),
            child: Assets.images.chatBubble1.image(
              width: 300 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }

  Stack Characters() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(bottom: 367 * hr),
            child: Assets.images.char1.image(
              width: 525 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 498 * wr, bottom: 344 * hr),
            child: Assets.images.char2.image(
              width: 597 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 1002 * wr, bottom: 400 * hr),
            child: Assets.images.char3.image(
              width: 510 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 1491 * wr, bottom: 416 * hr),
            child: Assets.images.char4.image(
              width: 495 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 975 * wr, bottom: 326 * hr),
            child: Assets.images.char5.image(
              width: 467 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 489 * wr, bottom: 380 * hr),
            child: Assets.images.char6.image(
              width: 556 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(bottom: 287 * hr),
            child: Assets.images.char7.image(
              width: 694 * wr,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }

  Align TopTextView(double height, BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '영피스',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: const Color(0xFF27E04E),
                      fontSize: 60,
                      shadows: shadows(),
                    ),
              ),
            ),
            const SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${teamCount.value}조',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: const Color(0xFFFFDE00),
                      fontSize: 60,
                      shadows: shadows(),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<int> TeamDrawTitle() {
    return ValueListenableBuilder(
      valueListenable: teamCount,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GradientText(
              '$value조',
              gradientDirection: GradientDirection.ttb,
              colors: const [Colors.white, Color(0xffed8629)],
              style: const TextStyle(fontSize: 60),
            ),
          ),
        );
      },
    );
  }

  double getNintendoHeight() {
    final nintendoRenderBox =
        nintendoKey.currentContext?.findRenderObject() as RenderBox?;
    final nintendoHeight = nintendoRenderBox?.size.height ?? 0;
    return nintendoHeight;
  }

  Widget MobileView(double width) {
    final teamDraw = ref.watch(adminDrawProvider);

    return Scaffold(
      backgroundColor: ColorName.blueDark,
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('내가 뽑힌 조는?',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: myNameTeamNumber,
                builder: (context, value, child) {
                  if (value == 0) return const SizedBox.shrink();
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value != 0 ? '$value조' : '',
                        style:
                            const TextStyle(fontSize: 60, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                teamDraw.teams[value - 1].names[index].name,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                          itemCount: teamDraw.teams[value - 1].names.length,
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('돌아가기'),
              ),
            ],
          ),
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

  void setMobileViewData() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final myTeamNumber = findMyNameTeamNumber();
      FireStoreFactory.adminOptionRef().snapshots().listen((event) {
        if (event.docs.first.data().current_showed_team_number ==
            myTeamNumber) {
          timer.cancel();
          myNameTeamNumber.value = myTeamNumber;
        }
      });
    });
  }
}
