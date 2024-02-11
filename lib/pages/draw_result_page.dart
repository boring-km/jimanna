import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class DrawResultPage extends ConsumerStatefulWidget {
  const DrawResultPage({super.key});

  @override
  ConsumerState<DrawResultPage> createState() => _DrawResultPageState();
}

class _DrawResultPageState extends ConsumerState<DrawResultPage> {
  final counter = ValueNotifier(10);
  final showResult = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    setAudioPlayer();
    setVideoPlayer();
  }

  void setVideoPlayer() {
    _controller =
        VideoPlayerController.asset('assets/videos/intro_video_5s.mp4')
          ..initialize().then((_) {
            setState(() {
              _controller.play().then((value) {
                _controller.setLooping(true);
                startResultTimer();
              });
            });
          });
  }

  void setAudioPlayer() {
    audioPlayer.setLoopMode(LoopMode.all);
    audioPlayer
        .setAsset(
          'assets/music/background_music.mp3',
          initialPosition: const Duration(seconds: 14),
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
        showResult.value = true;
      }
    });
  }

  final audioPlayer = AudioPlayer();
  late VideoPlayerController _controller;
  final nintendoKey = GlobalKey();

  @override
  void dispose() {
    _controller
      ..pause()
      ..dispose();
    audioPlayer
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final nintendoHeight = getNintendoHeight();

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Assets.images.nintendo.image(
              key: nintendoKey,
              width: width * 0.5,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Assets.images.gameController.image(
              width: width * 0.25,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Center(
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
        ],
      ),
    );
  }

  double getNintendoHeight() {
    final nintendoRenderBox =
        nintendoKey.currentContext?.findRenderObject() as RenderBox?;
    final nintendoHeight = nintendoRenderBox?.size.height ?? 0;
    return nintendoHeight;
  }
}
