/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/abad.png
  AssetGenImage get abad => const AssetGenImage('assets/images/abad.png');

  /// File path: assets/images/big_logo.png
  AssetGenImage get bigLogo =>
      const AssetGenImage('assets/images/big_logo.png');

  /// File path: assets/images/character_image.png
  AssetGenImage get characterImage =>
      const AssetGenImage('assets/images/character_image.png');

  /// File path: assets/images/confirm_button.png
  AssetGenImage get confirmButton =>
      const AssetGenImage('assets/images/confirm_button.png');

  /// File path: assets/images/draw_background.png
  AssetGenImage get drawBackground =>
      const AssetGenImage('assets/images/draw_background.png');

  /// File path: assets/images/emoji.gif
  AssetGenImage get emoji => const AssetGenImage('assets/images/emoji.gif');

  /// File path: assets/images/error.jpg
  AssetGenImage get error => const AssetGenImage('assets/images/error.jpg');

  /// File path: assets/images/game_controller.png
  AssetGenImage get gameController =>
      const AssetGenImage('assets/images/game_controller.png');

  /// File path: assets/images/health.gif
  AssetGenImage get health => const AssetGenImage('assets/images/health.gif');

  /// File path: assets/images/heart.gif
  AssetGenImage get heart => const AssetGenImage('assets/images/heart.gif');

  /// File path: assets/images/home_desktop_background.png
  AssetGenImage get homeDesktopBackground =>
      const AssetGenImage('assets/images/home_desktop_background.png');

  /// File path: assets/images/home_desktop_bottom.png
  AssetGenImage get homeDesktopBottom =>
      const AssetGenImage('assets/images/home_desktop_bottom.png');

  /// File path: assets/images/home_desktop_bottom_button.png
  AssetGenImage get homeDesktopBottomButton =>
      const AssetGenImage('assets/images/home_desktop_bottom_button.png');

  /// File path: assets/images/home_desktop_top.png
  AssetGenImage get homeDesktopTop =>
      const AssetGenImage('assets/images/home_desktop_top.png');

  /// File path: assets/images/home_image.png
  AssetGenImage get homeImage =>
      const AssetGenImage('assets/images/home_image.png');

  /// File path: assets/images/name_background1.png
  AssetGenImage get nameBackground1 =>
      const AssetGenImage('assets/images/name_background1.png');

  /// File path: assets/images/name_background2.png
  AssetGenImage get nameBackground2 =>
      const AssetGenImage('assets/images/name_background2.png');

  /// File path: assets/images/nintendo.png
  AssetGenImage get nintendo =>
      const AssetGenImage('assets/images/nintendo.png');

  /// File path: assets/images/result_background.png
  AssetGenImage get resultBackground =>
      const AssetGenImage('assets/images/result_background.png');

  /// File path: assets/images/star.gif
  AssetGenImage get star => const AssetGenImage('assets/images/star.gif');

  /// File path: assets/images/young_peace.png
  AssetGenImage get youngPeace =>
      const AssetGenImage('assets/images/young_peace.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        abad,
        bigLogo,
        characterImage,
        confirmButton,
        drawBackground,
        emoji,
        error,
        gameController,
        health,
        heart,
        homeDesktopBackground,
        homeDesktopBottom,
        homeDesktopBottomButton,
        homeDesktopTop,
        homeImage,
        nameBackground1,
        nameBackground2,
        nintendo,
        resultBackground,
        star,
        youngPeace
      ];
}

class $AssetsMusicGen {
  const $AssetsMusicGen();

  /// File path: assets/music/background2.mp3
  String get background2 => 'assets/music/background2.mp3';

  /// File path: assets/music/background_music.mp3
  String get backgroundMusic => 'assets/music/background_music.mp3';

  /// List of all assets
  List<String> get values => [background2, backgroundMusic];
}

class $AssetsVideosGen {
  const $AssetsVideosGen();

  /// File path: assets/videos/intro_video_10s.mp4
  String get introVideo10s => 'assets/videos/intro_video_10s.mp4';

  /// List of all assets
  List<String> get values => [introVideo10s];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMusicGen music = $AssetsMusicGen();
  static const $AssetsVideosGen videos = $AssetsVideosGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
