import 'package:breathe_app/core/backdrop/breathing_backdrop.dart';
import 'package:breathe_app/core/enums/backdrop_mode.dart';
import 'package:breathe_app/core/enums/backdrop_target.dart';
import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class SceneScaffold extends StatelessWidget {
  const SceneScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mode = isDark ? BackdropMode.dark : BackdropMode.light;

    return Scaffold(
      backgroundColor: AppColors.frameBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final target = constraints.maxWidth >= 900
              ? BackdropTarget.web
              : BackdropTarget.mobile;

          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              BreathingBackdrop(mode: mode, target: target),
              SafeArea(child: child),
            ],
          );
        },
      ),
    );
  }
}
