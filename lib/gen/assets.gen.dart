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

  /// File path: assets/images/character_image.png
  AssetGenImage get characterImage =>
      const AssetGenImage('assets/images/character_image.png');

  /// File path: assets/images/confirm_button.png
  AssetGenImage get confirmButton =>
      const AssetGenImage('assets/images/confirm_button.png');

  /// File path: assets/images/emoji.gif
  AssetGenImage get emoji => const AssetGenImage('assets/images/emoji.gif');

  /// File path: assets/images/health.gif
  AssetGenImage get health => const AssetGenImage('assets/images/health.gif');

  /// File path: assets/images/heart.gif
  AssetGenImage get heart => const AssetGenImage('assets/images/heart.gif');

  /// File path: assets/images/home_image.png
  AssetGenImage get homeImage =>
      const AssetGenImage('assets/images/home_image.png');

  /// File path: assets/images/star.gif
  AssetGenImage get star => const AssetGenImage('assets/images/star.gif');

  /// List of all assets
  List<AssetGenImage> get values => [
        abad,
        characterImage,
        confirmButton,
        emoji,
        health,
        heart,
        homeImage,
        star
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
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
