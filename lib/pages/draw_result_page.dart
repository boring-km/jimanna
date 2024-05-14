import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/gen/colors.gen.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/providers/current_name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/routes.dart';
import 'package:jimanna/ui/background_painter.dart';
import 'package:jimanna/ui/ongmezim_text.dart';
import 'package:jimanna/utils/background_audio_player.dart';
import 'package:just_audio/just_audio.dart';
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
  final showResult = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    isMobileState = widget.isMobile;
    _controller = VideoPlayerController.asset('assets/videos/intro_video_5s.mp4');

    if (isMobileState) {
      setMobileViewData();
    } else {
      setVideoPlayer();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      moveIfDrawEnd(context);
    });
  }

  void setVideoPlayer() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.initialize().then((_) {
        setState(() {
          _controller.play().then((_) {
            _controller.setLooping(true);
            startResultTimer();
          });
          setAudioPlayer();
        });
      });
    });
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

  void startResultTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      counter.value--;
      if (counter.value == 0) {
        timer.cancel();
        _controller.pause();
        showResult.value = true;
        showNamesWithTimer();
      }
    });
  }

  final teamCount = ValueNotifier(1);
  final leftTopName = ValueNotifier('');
  final rightTopName = ValueNotifier('');
  final leftBottomName = ValueNotifier('');
  final rightBottomName = ValueNotifier('');

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
      for (var i = 0; i < team.names.length; i++) {
        if (i == 0) {
          // TODO type 넣기
          leftTopName.value = team.names[i].name;
          await Future.delayed(const Duration(milliseconds: 500));
        } else if (i == 1) {
          rightTopName.value = team.names[i].name;
          await Future.delayed(const Duration(milliseconds: 500));
        } else if (i == 2) {
          leftBottomName.value = team.names[i].name;
          await Future.delayed(const Duration(milliseconds: 500));
        } else if (i == 3) {
          rightBottomName.value = team.names[i].name;
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
      ref.read(adminOptionsProvider.notifier).updateTeamNumber(teamIndex + 1);
      await Future.delayed(const Duration(seconds: 4));
      if (teamIndex < teamDraw.teams.length - 1) {
        teamCount.value++;
      }
      leftTopName.value = '';
      rightTopName.value = '';
      leftBottomName.value = '';
      rightBottomName.value = '';
    }
    ref.read(adminOptionsProvider.notifier).endDraw();
    unawaited(Navigator.popAndPushNamed(context, Routes.drawTotalResultPage));
  }

  late VideoPlayerController _controller;
  final nintendoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ref
      ..read(adminOptionsProvider.notifier)
      ..read(adminDrawProvider);

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

  Scaffold DesktopView(double width, double height, double nintendoHeight) {
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
          BottomText(context, width * (3/4), height),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: Assets.images.nintendo.image(
                key: nintendoKey,
                width: width * 0.5,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Assets.images.gameController.image(
              width: width * 0.25,
              alignment: Alignment.bottomCenter,
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
          ValueListenableBuilder(
            valueListenable: showResult,
            builder: (context, value, child) {
              if (value) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Center(
                    child: SizedBox(
                      width: nintendoHeight * (16 / 9),
                      height: nintendoHeight,
                      child: Stack(
                        children: [
                          Assets.images.resultBackground.image(),
                          TeamDrawTitle(),
                          LeftTopName(),
                          RightTopName(),
                          LeftBottomName(),
                          RightBottomName(),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
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

  Widget LeftTopName() {
    return ValueListenableBuilder(
      valueListenable: leftTopName,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 90, top: 110),
            child: GradientText(
              value,
              gradientDirection: GradientDirection.ttb,
              colors: const [Colors.white, Colors.green],
              style: const TextStyle(fontSize: 60),
            ),
          ),
        );
      },
    );
  }

  Widget RightTopName() {
    return ValueListenableBuilder(
      valueListenable: rightTopName,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 90, top: 110),
            child: GradientText(
              value,
              gradientDirection: GradientDirection.ttb,
              colors: const [Colors.white, Colors.green],
              style: const TextStyle(fontSize: 60),
            ),
          ),
        );
      },
    );
  }

  Widget LeftBottomName() {
    return ValueListenableBuilder(
      valueListenable: leftBottomName,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 90, bottom: 80),
            child: GradientText(
              value,
              gradientDirection: GradientDirection.ttb,
              colors: const [Colors.white, Colors.green],
              style: const TextStyle(fontSize: 60),
            ),
          ),
        );
      },
    );
  }

  Widget RightBottomName() {
    return ValueListenableBuilder(
      valueListenable: rightBottomName,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 90, bottom: 80),
            child: GradientText(
              value,
              gradientDirection: GradientDirection.ttb,
              colors: const [Colors.white, Colors.green],
              style: const TextStyle(fontSize: 60),
            ),
          ),
        );
      },
    );
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
        if (event.docs.first.data().current_showed_team_number == myTeamNumber) {
          timer.cancel();
          myNameTeamNumber.value = myTeamNumber;
        }
      });
    });
  }
}
