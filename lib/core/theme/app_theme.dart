import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const String _fontFamily = 'Quicksand';

  static ThemeData get light {
    return _buildTheme(
      brightness: Brightness.light,
      textColor: AppColors.textLight,
      mutedColor: AppColors.mutedLight,
      secondaryButtonColor: AppColors.secondaryButtonLight,
    );
  }

  static ThemeData get dark {
    return _buildTheme(
      brightness: Brightness.dark,
      textColor: AppColors.textDark,
      mutedColor: AppColors.mutedDark,
      secondaryButtonColor: AppColors.secondaryButtonDark,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color textColor,
    required Color mutedColor,
    required Color secondaryButtonColor,
  }) {
    final base = ThemeData(
      brightness: brightness,
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: AppColors.frameBackground,
      useMaterial3: true,
    );

    final textTheme = base.textTheme.copyWith(
      headlineLarge: base.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 48,
        color: textColor,
      ),
      headlineMedium: base.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: textColor,
      ),
      headlineSmall: base.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 56,
        color: textColor,
      ),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 56,
        color: textColor,
      ),
      titleMedium: base.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 52,
        color: textColor,
      ),
      bodyLarge: base.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: textColor,
      ),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: mutedColor,
      ),
      labelLarge: base.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: textColor,
      ),
      labelMedium: base.textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: mutedColor,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primaryButton,
          foregroundColor: AppColors.onPrimaryButton,
          minimumSize: const Size(250, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: secondaryButtonColor,
          foregroundColor: textColor,
          minimumSize: const Size(250, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
