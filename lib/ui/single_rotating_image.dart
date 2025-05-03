import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:jimanna/gen/assets.gen.dart';


class SingleRotatingImage extends StatefulWidget {
  const SingleRotatingImage({super.key});

  @override
  State<SingleRotatingImage> createState() => _SingleRotatingImageState();
}

class _SingleRotatingImageState extends State<SingleRotatingImage> with SingleTickerProviderStateMixin {

  Timer? _timer;
  Timer? _speedTimer;
  double _angle = 0;
  ui.Image? _image;
  double _speed = 0.001; // 회전 속도

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadImage();
    });
    _speedTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _speed += 0.0005; // 회전 속도 증가
        if (_speed > 0.01) _speed += 0.001; // 속도 증가
        if (_speed > 3) _speed = 3; // 최대 속도 제한
      });
    });

    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _angle += _speed; // 회전 속도
        if (_angle > 2 * pi) _angle -= 2 * pi;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speedTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SingleRotatingImagePainter(_angle, _image),
      child: Container(),
    );
  }

  Future<void> _loadImage() async {
    final image = await loadUiImage(context, Assets.images.kangmin.path);
    setState(() {
      _image = image;
    });
  }
}

class SingleRotatingImagePainter extends CustomPainter {
  SingleRotatingImagePainter(this.angle, this.image);

  final double angle;
  final ui.Image? image;

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) return;
    final paint = Paint();

    canvas
      ..save()
      ..translate(size.width / 2, 0)
      ..rotate(angle)
      ..scale(0.2)
      ..drawImage(image!, Offset(-image!.width / 2, -image!.height / 2), paint)
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Future<ui.Image> loadUiImage(BuildContext context, String assetPath) async {
  final data = await DefaultAssetBundle.of(context).load(assetPath);
  final bytes = data.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}