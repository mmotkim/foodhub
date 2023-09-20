/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/fb.png
  AssetGenImage get fb => const AssetGenImage('assets/icons/fb.png');

  /// File path: assets/icons/gg.png
  AssetGenImage get gg => const AssetGenImage('assets/icons/gg.png');

  /// List of all assets
  List<AssetGenImage> get values => [fb, gg];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/welcomeBG.png
  AssetGenImage get welcomeBG =>
      const AssetGenImage('assets/images/welcomeBG.png');

  /// File path: assets/images/welcomeBackground.png
  AssetGenImage get welcomeBackground =>
      const AssetGenImage('assets/images/welcomeBackground.png');

  /// List of all assets
  List<AssetGenImage> get values => [welcomeBG, welcomeBackground];
}

class Assets {
  Assets._();

  static const AssetGenImage background =
      AssetGenImage('assets/background.png');
  static const AssetGenImage brand = AssetGenImage('assets/brand.png');
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const AssetGenImage logo = AssetGenImage('assets/logo.png');
  static const AssetGenImage logoSplash =
      AssetGenImage('assets/logoSplash.png');
  static const AssetGenImage splash = AssetGenImage('assets/splash.png');
  static const AssetGenImage topDeco = AssetGenImage('assets/topDeco.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [background, brand, logo, logoSplash, splash, topDeco];
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
