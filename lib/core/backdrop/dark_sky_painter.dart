import 'package:breathe_app/core/enums/backdrop_target.dart';
import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class DarkSkyPainter extends CustomPainter {
  const DarkSkyPainter({required this.target});

  final BackdropTarget target;

  static const List<Offset> _mobileDots = <Offset>[
    Offset(0.17, 0.09),
    Offset(0.24, 0.10),
    Offset(0.29, 0.10),
    Offset(0.49, 0.06),
    Offset(0.56, 0.04),
    Offset(0.61, 0.11),
    Offset(0.41, 0.12),
    Offset(0.52, 0.14),
    Offset(0.92, 0.16),
    Offset(0.95, 0.20),
    Offset(0.74, 0.17),
    Offset(0.77, 0.21),
    Offset(0.62, 0.26),
    Offset(0.33, 0.27),
    Offset(0.25, 0.24),
    Offset(0.18, 0.33),
    Offset(0.45, 0.35),
    Offset(0.69, 0.32),
    Offset(0.88, 0.37),
    Offset(0.81, 0.44),
    Offset(0.73, 0.49),
    Offset(0.65, 0.52),
    Offset(0.56, 0.50),
    Offset(0.47, 0.47),
    Offset(0.38, 0.46),
    Offset(0.29, 0.45),
    Offset(0.19, 0.41),
    Offset(0.11, 0.30),
    Offset(0.93, 0.53),
    Offset(0.87, 0.60),
    Offset(0.73, 0.67),
    Offset(0.60, 0.70),
    Offset(0.41, 0.72),
    Offset(0.24, 0.58),
    Offset(0.26, 0.76),
    Offset(0.42, 0.84),
    Offset(0.58, 0.86),
    Offset(0.73, 0.81),
    Offset(0.83, 0.68),
  ];

  static const List<Offset> _webDots = <Offset>[
    Offset(0.12, 0.11),
    Offset(0.21, 0.12),
    Offset(0.28, 0.10),
    Offset(0.41, 0.09),
    Offset(0.53, 0.12),
    Offset(0.62, 0.10),
    Offset(0.75, 0.11),
    Offset(0.88, 0.14),
    Offset(0.16, 0.23),
    Offset(0.29, 0.24),
    Offset(0.41, 0.22),
    Offset(0.57, 0.23),
    Offset(0.69, 0.24),
    Offset(0.82, 0.27),
    Offset(0.12, 0.38),
    Offset(0.22, 0.41),
    Offset(0.34, 0.39),
    Offset(0.47, 0.36),
    Offset(0.63, 0.38),
    Offset(0.79, 0.39),
    Offset(0.90, 0.41),
    Offset(0.18, 0.55),
    Offset(0.32, 0.61),
    Offset(0.47, 0.59),
    Offset(0.61, 0.63),
    Offset(0.74, 0.58),
    Offset(0.89, 0.60),
    Offset(0.23, 0.75),
    Offset(0.41, 0.70),
    Offset(0.58, 0.69),
    Offset(0.69, 0.74),
    Offset(0.81, 0.71),
    Offset(0.33, 0.89),
    Offset(0.47, 0.86),
    Offset(0.62, 0.84),
    Offset(0.75, 0.90),
  ];

  static const List<Offset> _mobileStars = <Offset>[
    Offset(0.45, 0.12),
    Offset(0.30, 0.20),
    Offset(0.61, 0.24),
    Offset(0.77, 0.31),
    Offset(0.22, 0.40),
    Offset(0.60, 0.44),
    Offset(0.67, 0.58),
  ];

  static const List<Offset> _webStars = <Offset>[
    Offset(0.45, 0.07),
    Offset(0.67, 0.24),
    Offset(0.26, 0.24),
    Offset(0.50, 0.31),
    Offset(0.33, 0.43),
    Offset(0.62, 0.49),
    Offset(0.71, 0.76),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final dots = target == BackdropTarget.mobile ? _mobileDots : _webDots;
    final stars = target == BackdropTarget.mobile ? _mobileStars : _webStars;

    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.darkStar.withValues(alpha: 0.82);

    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)
      ..color = AppColors.darkStarGlow.withValues(alpha: 0.18);

    for (var i = 0; i < dots.length; i++) {
      final point = Offset(dots[i].dx * size.width, dots[i].dy * size.height);
      final radius = i % 3 == 0 ? 1.3 : 0.95;
      canvas.drawCircle(point, radius, dotPaint);

      if (i % 11 == 0) {
        canvas.drawCircle(point, radius * 2.4, glowPaint);
      }
    }

    final starPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.8
      ..color = const Color(0xFFECE6F7).withValues(alpha: 0.42);

    final starGlowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..color = const Color(0xFFECE6F7).withValues(alpha: 0.16);

    for (final star in stars) {
      final center = Offset(star.dx * size.width, star.dy * size.height);
      _drawCrossStar(canvas, center, starPaint, starGlowPaint);
    }
  }

  void _drawCrossStar(
    Canvas canvas,
    Offset center,
    Paint paint,
    Paint glowPaint,
  ) {
    const arm = 10.0;
    const shortArm = 4.0;

    final horizontal = <Offset>[
      center.translate(-arm, 0),
      center.translate(arm, 0),
    ];
    final vertical = <Offset>[
      center.translate(0, -arm),
      center.translate(0, arm),
    ];
    final diagonalA = <Offset>[
      center.translate(-shortArm, -shortArm),
      center.translate(shortArm, shortArm),
    ];
    final diagonalB = <Offset>[
      center.translate(-shortArm, shortArm),
      center.translate(shortArm, -shortArm),
    ];

    canvas.drawLine(horizontal.first, horizontal.last, glowPaint);
    canvas.drawLine(vertical.first, vertical.last, glowPaint);

    canvas.drawLine(horizontal.first, horizontal.last, paint);
    canvas.drawLine(vertical.first, vertical.last, paint);
    final diagonalPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.45
      ..color = const Color(0xFFECE6F7).withValues(alpha: 0.18);
    canvas.drawLine(diagonalA.first, diagonalA.last, diagonalPaint);
    canvas.drawLine(diagonalB.first, diagonalB.last, diagonalPaint);
  }

  @override
  bool shouldRepaint(covariant DarkSkyPainter oldDelegate) {
    return oldDelegate.target != target;
  }
}
