// dart format width=100

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/svg
  $AssetsIconsSvgGen get svg => const $AssetsIconsSvgGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/background
  $AssetsImagesBackgroundGen get background => const $AssetsImagesBackgroundGen();
}

class $AssetsIconsSvgGen {
  const $AssetsIconsSvgGen();

  /// File path: assets/icons/svg/fast-wind.svg
  SvgGenImage get fastWind => const SvgGenImage('assets/icons/svg/fast-wind.svg');

  /// List of all assets
  List<SvgGenImage> get values => [fastWind];
}

class $AssetsImagesBackgroundGen {
  const $AssetsImagesBackgroundGen();

  /// File path: assets/images/background/dark_big_cloud.png
  AssetGenImage get darkBigCloud =>
      const AssetGenImage('assets/images/background/dark_big_cloud.png');

  /// File path: assets/images/background/dark_medium_cloud.png
  AssetGenImage get darkMediumCloud =>
      const AssetGenImage('assets/images/background/dark_medium_cloud.png');

  /// File path: assets/images/background/dark_purple_medium_cloud.png
  AssetGenImage get darkPurpleMediumCloud =>
      const AssetGenImage('assets/images/background/dark_purple_medium_cloud.png');

  /// File path: assets/images/background/dark_purple_small_cloud.png
  AssetGenImage get darkPurpleSmallCloud =>
      const AssetGenImage('assets/images/background/dark_purple_small_cloud.png');

  /// File path: assets/images/background/dark_small_cloud_1.png
  AssetGenImage get darkSmallCloud1 =>
      const AssetGenImage('assets/images/background/dark_small_cloud_1.png');

  /// File path: assets/images/background/dark_small_cloud_2.png
  AssetGenImage get darkSmallCloud2 =>
      const AssetGenImage('assets/images/background/dark_small_cloud_2.png');

  /// File path: assets/images/background/light_big_cloud.png
  AssetGenImage get lightBigCloud =>
      const AssetGenImage('assets/images/background/light_big_cloud.png');

  /// File path: assets/images/background/light_medium_cloud.png
  AssetGenImage get lightMediumCloud =>
      const AssetGenImage('assets/images/background/light_medium_cloud.png');

  /// File path: assets/images/background/light_purple_medium_cloud.png
  AssetGenImage get lightPurpleMediumCloud =>
      const AssetGenImage('assets/images/background/light_purple_medium_cloud.png');

  /// File path: assets/images/background/light_purple_small_cloud.png
  AssetGenImage get lightPurpleSmallCloud =>
      const AssetGenImage('assets/images/background/light_purple_small_cloud.png');

  /// File path: assets/images/background/light_small_cloud_1.png
  AssetGenImage get lightSmallCloud1 =>
      const AssetGenImage('assets/images/background/light_small_cloud_1.png');

  /// File path: assets/images/background/light_small_cloud_2.png
  AssetGenImage get lightSmallCloud2 =>
      const AssetGenImage('assets/images/background/light_small_cloud_2.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    darkBigCloud,
    darkMediumCloud,
    darkPurpleMediumCloud,
    darkPurpleSmallCloud,
    darkSmallCloud1,
    darkSmallCloud2,
    lightBigCloud,
    lightMediumCloud,
    lightPurpleMediumCloud,
    lightPurpleSmallCloud,
    lightSmallCloud1,
    lightSmallCloud2,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(_assetName, assetBundle: bundle, packageName: package);
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
