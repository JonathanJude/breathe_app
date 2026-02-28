import 'package:breathe_app/core/backdrop/backdrop_scene.dart';
import 'package:breathe_app/core/backdrop/dark_sky_painter.dart';
import 'package:breathe_app/core/enums/backdrop_mode.dart';
import 'package:breathe_app/core/enums/backdrop_target.dart';
import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class BreathingBackdrop extends StatelessWidget {
  const BreathingBackdrop({
    required this.mode,
    required this.target,
    super.key,
  });

  final BackdropMode mode;
  final BackdropTarget target;

  @override
  Widget build(BuildContext context) {
    final gradient = mode == BackdropMode.dark
        ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.darkTop,
              AppColors.darkMiddle,
              AppColors.darkBottom,
            ],
            stops: <double>[0, 0.44, 1],
          )
        : const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.lightTop,
              AppColors.lightMiddle,
              AppColors.lightBottom,
            ],
            stops: <double>[0, 0.48, 1],
          );

    final clouds = mode == BackdropMode.dark
        ? BackdropScene.dark(target)
        : BackdropScene.light(target);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;

        return DecoratedBox(
          decoration: BoxDecoration(gradient: gradient),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              if (mode == BackdropMode.dark)
                CustomPaint(painter: DarkSkyPainter(target: target)),
              ...clouds.map((cloud) {
                return Positioned(
                  left: cloud.x * size.width,
                  top: cloud.y * size.height,
                  width: cloud.widthFactor * size.width,
                  child: Opacity(
                    opacity: cloud.opacity,
                    child: cloud.asset.image(fit: BoxFit.contain),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
