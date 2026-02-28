class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);

  static const Duration sessionTick = Duration(seconds: 1);

  static Duration breathingPhase(int seconds) => Duration(seconds: seconds);
}
