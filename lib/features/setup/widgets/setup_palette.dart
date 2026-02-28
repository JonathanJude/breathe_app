import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class SetupPalette {
  const SetupPalette._({
    required this.title,
    required this.pageTitleColor,
    required this.subtitle,
    required this.cardBackground,
    required this.cardBorder,
    required this.divider,
    required this.chipBackground,
    required this.chipText,
    required this.chipSelectedBackground,
    required this.chipSelectedBorder,
    required this.chipSelectedText,
    required this.phaseRowBackground,
    required this.phaseRowBorder,
    required this.phaseRowText,
    required this.stepperButtonBackground,
    required this.stepperButtonForeground,
    required this.soundTrack,
    required this.soundThumb,
    required this.primaryButton,
    required this.primaryButtonText,
    required this.secondaryButton,
    required this.breathDurationOptions,
    required this.showStartIcon,
  });

  final Color title;
  final Color pageTitleColor;
  final Color subtitle;
  final Color cardBackground;
  final Color cardBorder;
  final Color divider;
  final Color chipBackground;
  final Color chipText;
  final Color chipSelectedBackground;
  final Color chipSelectedBorder;
  final Color chipSelectedText;
  final Color phaseRowBackground;
  final Color phaseRowBorder;
  final Color phaseRowText;
  final Color stepperButtonBackground;
  final Color stepperButtonForeground;
  final Color soundTrack;
  final Color soundThumb;
  final Color primaryButton;
  final Color primaryButtonText;
  final Color secondaryButton;
  final List<int> breathDurationOptions;
  final bool showStartIcon;

  factory SetupPalette.fromTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const SetupPalette._(
        title: AppColors.textDark,
        pageTitleColor: AppColors.textDark,
        subtitle: Color(0xFF9E93B9),
        cardBackground: Color(0x5A4A3A78),
        cardBorder: Color(0x14FFFFFF),
        divider: Color(0x22FFFFFF),
        chipBackground: Color(0xFF101014),
        chipText: Color(0xFF8F8B9B),
        chipSelectedBackground: Color(0xFF6E3200),
        chipSelectedBorder: Color(0xFFE28300),
        chipSelectedText: Color(0xFFFFB22C),
        phaseRowBackground: Color(0xFF0F1014),
        phaseRowBorder: Color(0xFF0F1014),
        phaseRowText: Color(0xFFF5F4F8),
        stepperButtonBackground: Color(0xFF4E4E51),
        stepperButtonForeground: Color(0xFFFFFFFF),
        soundTrack: Color(0xFF8D3D98),
        soundThumb: Color(0xFFFFFFFF),
        primaryButton: Color(0xFF8A3E99),
        primaryButtonText: Color(0xFFFFFFFF),
        secondaryButton: Color(0x58FFFFFF),
        breathDurationOptions: <int>[3, 4, 5, 10],
        showStartIcon: false,
      );
    }

    return const SetupPalette._(
      title: Color(0xFF1D1A22),
      pageTitleColor: Color(0xFF6B0A72),
      subtitle: AppColors.mutedLight,
      cardBackground: Color(0xFFFFFFFF),
      cardBorder: Color(0x26FFFFFF),
      divider: Color(0xFFE6E6E8),
      chipBackground: Color(0xFFF0F0F2),
      chipText: Color(0xFF87868E),
      chipSelectedBackground: Color(0xFFFFFFFF),
      chipSelectedBorder: Color(0xFFE47D00),
      chipSelectedText: Color(0xFFE47D00),
      phaseRowBackground: Color(0xFFF7F7F7),
      phaseRowBorder: Color(0xFFF5F5F5),
      phaseRowText: Color(0xFF222126),
      stepperButtonBackground: Color(0xFFFFFFFF),
      stepperButtonForeground: Color(0xFF26252C),
      soundTrack: Color(0xFF74007D),
      soundThumb: Color(0xFFFFFFFF),
      primaryButton: AppColors.primaryButton,
      primaryButtonText: AppColors.onPrimaryButton,
      secondaryButton: AppColors.secondaryButtonLight,
      breathDurationOptions: <int>[3, 4, 5, 6],
      showStartIcon: true,
    );
  }
}
