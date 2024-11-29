/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $EnvGen {
  const $EnvGen();

  /// File path: env/.env.dev
  String get aEnvDev => 'env/.env.dev';

  /// File path: env/.env.prod
  String get aEnvProd => 'env/.env.prod';

  /// List of all assets
  List<String> get values => [aEnvDev, aEnvProd];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/apps.svg
  SvgGenImage get apps => const SvgGenImage('assets/icons/apps.svg');

  /// File path: assets/icons/auto-reply.svg
  SvgGenImage get autoReply => const SvgGenImage('assets/icons/auto-reply.svg');

  /// File path: assets/icons/chatbot-speech-bubble.svg
  SvgGenImage get chatbotSpeechBubble =>
      const SvgGenImage('assets/icons/chatbot-speech-bubble.svg');

  /// File path: assets/icons/clouds.svg
  SvgGenImage get clouds => const SvgGenImage('assets/icons/clouds.svg');

  /// File path: assets/icons/guide-alt.svg
  SvgGenImage get guideAlt => const SvgGenImage('assets/icons/guide-alt.svg');

  /// File path: assets/icons/messages-question.svg
  SvgGenImage get messagesQuestion =>
      const SvgGenImage('assets/icons/messages-question.svg');

  /// File path: assets/icons/phone-call.svg
  SvgGenImage get phoneCall => const SvgGenImage('assets/icons/phone-call.svg');

  /// File path: assets/icons/revenue.svg
  SvgGenImage get revenue => const SvgGenImage('assets/icons/revenue.svg');

  /// File path: assets/icons/screen-play.svg
  SvgGenImage get screenPlay =>
      const SvgGenImage('assets/icons/screen-play.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/solar-panel-sun.svg
  SvgGenImage get solarPanelSun =>
      const SvgGenImage('assets/icons/solar-panel-sun.svg');

  /// File path: assets/icons/square.svg
  SvgGenImage get square => const SvgGenImage('assets/icons/square.svg');

  /// File path: assets/icons/thunderstorm-sun_6854078.svg
  SvgGenImage get thunderstormSun6854078 =>
      const SvgGenImage('assets/icons/thunderstorm-sun_6854078.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        apps,
        autoReply,
        chatbotSpeechBubble,
        clouds,
        guideAlt,
        messagesQuestion,
        phoneCall,
        revenue,
        screenPlay,
        search,
        solarPanelSun,
        square,
        thunderstormSun6854078
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cotdien.png
  AssetGenImage get cotdien => const AssetGenImage('assets/images/cotdien.png');

  /// File path: assets/images/electric-pole.png
  AssetGenImage get electricPole =>
      const AssetGenImage('assets/images/electric-pole.png');

  /// File path: assets/images/exclamation.png
  AssetGenImage get exclamation =>
      const AssetGenImage('assets/images/exclamation.png');

  /// File path: assets/images/factory.png
  AssetGenImage get factory => const AssetGenImage('assets/images/factory.png');

  /// File path: assets/images/solar-panel.png
  AssetGenImage get solarPanel =>
      const AssetGenImage('assets/images/solar-panel.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [cotdien, electricPole, exclamation, factory, solarPanel];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $EnvGen env = $EnvGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

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
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
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
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
