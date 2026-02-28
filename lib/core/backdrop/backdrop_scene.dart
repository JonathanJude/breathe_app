import 'package:breathe_app/core/enums/backdrop_target.dart';
import 'package:breathe_app/gen/assets.gen.dart';

class CloudSpec {
  const CloudSpec({
    required this.asset,
    required this.x,
    required this.y,
    required this.widthFactor,
    this.opacity = 1,
  });

  final AssetGenImage asset;
  final double x;
  final double y;
  final double widthFactor;
  final double opacity;
}

class BackdropScene {
  static AssetGenImage get _lightBigCloud =>
      Assets.images.background.lightBigCloud;
  static AssetGenImage get _lightMediumCloud =>
      Assets.images.background.lightMediumCloud;
  static AssetGenImage get _lightSmallCloud1 =>
      Assets.images.background.lightSmallCloud1;
  static AssetGenImage get _lightSmallCloud2 =>
      Assets.images.background.lightSmallCloud2;
  static AssetGenImage get _lightPurpleMedium =>
      Assets.images.background.lightPurpleMediumCloud;

  static AssetGenImage get _darkBigCloud =>
      Assets.images.background.darkBigCloud;
  static AssetGenImage get _darkMediumCloud =>
      Assets.images.background.darkMediumCloud;
  static AssetGenImage get _darkSmallCloud2 =>
      Assets.images.background.darkSmallCloud2;
  static AssetGenImage get _darkPurpleSmall =>
      Assets.images.background.darkPurpleSmallCloud;
  static AssetGenImage get _darkPurpleMedium =>
      Assets.images.background.darkPurpleMediumCloud;

  static List<CloudSpec> light(BackdropTarget target) {
    //for mobile devices
    if (target == BackdropTarget.mobile) {
      return <CloudSpec>[
        CloudSpec(asset: _lightBigCloud, x: 0.23, y: 0.01, widthFactor: 0.79),
        CloudSpec(
          asset: _lightPurpleMedium,
          x: 0.05,
          y: 0.10,
          widthFactor: 0.30,
        ),
        CloudSpec(
          asset: _lightSmallCloud1,
          x: 0.00,
          y: 0.22,
          widthFactor: 0.22,
        ),
        CloudSpec(
          asset: _lightSmallCloud2,
          x: 0.87,
          y: 0.31,
          widthFactor: 0.20,
        ),
        CloudSpec(
          asset: _lightMediumCloud,
          x: 0.47,
          y: 0.16,
          widthFactor: 0.22,
        ),
        CloudSpec(asset: _lightBigCloud, x: -0.11, y: 0.76, widthFactor: 0.59),
        CloudSpec(asset: _lightBigCloud, x: 0.27, y: 0.76, widthFactor: 0.63),
        CloudSpec(asset: _lightBigCloud, x: 0.74, y: 0.75, widthFactor: 0.63),
      ];
    }

    //for web / tablet devices
    return <CloudSpec>[
      CloudSpec(asset: _lightBigCloud, x: 0.84, y: 0.01, widthFactor: 0.18),
      CloudSpec(asset: _lightPurpleMedium, x: 0.07, y: 0.07, widthFactor: 0.12),
      CloudSpec(asset: _lightSmallCloud2, x: 0.86, y: 0.23, widthFactor: 0.09),
      CloudSpec(asset: _lightSmallCloud1, x: 0.03, y: 0.29, widthFactor: 0.09),
      CloudSpec(asset: _lightSmallCloud1, x: 0.87, y: 0.60, widthFactor: 0.08),
      CloudSpec(asset: _lightMediumCloud, x: 0.67, y: 0.18, widthFactor: 0.08),
      CloudSpec(asset: _lightMediumCloud, x: 0.24, y: 0.20, widthFactor: 0.08),
      CloudSpec(asset: _lightBigCloud, x: -0.06, y: 0.82, widthFactor: 0.24),
      CloudSpec(asset: _lightBigCloud, x: 0.10, y: 0.89, widthFactor: 0.20),
      CloudSpec(asset: _lightBigCloud, x: 0.79, y: 0.80, widthFactor: 0.22),
    ];
  }

  static List<CloudSpec> dark(BackdropTarget target) {
    //for mobile
    if (target == BackdropTarget.mobile) {
      return <CloudSpec>[
        CloudSpec(asset: _darkBigCloud, x: 0.21, y: 0.01, widthFactor: 0.81),
        CloudSpec(
          asset: _darkPurpleMedium,
          x: 0.06,
          y: 0.10,
          widthFactor: 0.31,
        ),
        CloudSpec(asset: _darkMediumCloud, x: 0.49, y: 0.16, widthFactor: 0.22),
        CloudSpec(asset: _darkMediumCloud, x: 0.00, y: 0.31, widthFactor: 0.21),
        CloudSpec(asset: _darkSmallCloud2, x: 0.83, y: 0.23, widthFactor: 0.19),
        CloudSpec(asset: _darkPurpleSmall, x: 0.00, y: 0.49, widthFactor: 0.20),
        CloudSpec(asset: _darkPurpleSmall, x: 0.77, y: 0.30, widthFactor: 0.23),
        CloudSpec(
          asset: _darkPurpleMedium,
          x: 0.20,
          y: 0.69,
          widthFactor: 0.62,
        ),
        CloudSpec(
          asset: _darkMediumCloud,
          x: -0.10,
          y: 0.74,
          widthFactor: 0.63,
        ),
        CloudSpec(asset: _darkMediumCloud, x: 0.28, y: 0.75, widthFactor: 0.65),
      ];
    }

    //for web / tablet devices
    return <CloudSpec>[
      CloudSpec(asset: _darkBigCloud, x: 0.83, y: 0.00, widthFactor: 0.18),
      CloudSpec(asset: _darkPurpleMedium, x: 0.06, y: 0.10, widthFactor: 0.11),
      CloudSpec(asset: _darkMediumCloud, x: 0.03, y: 0.29, widthFactor: 0.07),
      CloudSpec(asset: _darkSmallCloud2, x: 0.87, y: 0.25, widthFactor: 0.07),
      CloudSpec(asset: _darkSmallCloud2, x: 0.97, y: 0.37, widthFactor: 0.06),
      CloudSpec(asset: _darkPurpleSmall, x: 0.69, y: 0.18, widthFactor: 0.05),
      CloudSpec(asset: _darkPurpleSmall, x: 0.05, y: 0.79, widthFactor: 0.08),
      CloudSpec(asset: _darkPurpleMedium, x: 0.13, y: 0.87, widthFactor: 0.31),
      CloudSpec(asset: _darkPurpleMedium, x: 0.79, y: 0.79, widthFactor: 0.25),
      CloudSpec(asset: _darkMediumCloud, x: -0.06, y: 0.82, widthFactor: 0.25),
    ];
  }
}
