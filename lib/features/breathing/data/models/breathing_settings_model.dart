import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';

class BreathingSettingsModel {
  const BreathingSettingsModel({
    required this.breathDurationSeconds,
    required this.rounds,
    required this.advancedTimingEnabled,
    required this.inhaleSeconds,
    required this.holdInSeconds,
    required this.exhaleSeconds,
    required this.holdOutSeconds,
    required this.soundEnabled,
  });

  factory BreathingSettingsModel.fromEntity(BreathingSettings entity) {
    return BreathingSettingsModel(
      breathDurationSeconds: entity.breathDurationSeconds,
      rounds: entity.rounds,
      advancedTimingEnabled: entity.advancedTimingEnabled,
      inhaleSeconds: entity.inhaleSeconds,
      holdInSeconds: entity.holdInSeconds,
      exhaleSeconds: entity.exhaleSeconds,
      holdOutSeconds: entity.holdOutSeconds,
      soundEnabled: entity.soundEnabled,
    );
  }

  factory BreathingSettingsModel.fromJson(Map<String, dynamic> json) {
    const defaults = BreathingSettings.defaults;

    final rawDuration =
        (json['breathDurationSeconds'] as num?)?.toInt() ??
        (json['sessionDurationMinutes'] as num?)?.toInt();
    final rawRounds = (json['rounds'] as num?)?.toInt();

    final breathDurationSeconds = BreathingSettings.breathDurationOptions.contains(rawDuration)
        ? rawDuration!
        : defaults.breathDurationSeconds;
    final rounds = BreathingSettings.roundOptions.contains(rawRounds) ? rawRounds! : defaults.rounds;

    final advancedTimingEnabled = json['advancedTimingEnabled'] as bool? ?? defaults.advancedTimingEnabled;

    final inhale = _resolvedPhaseValue(
      value: (json['inhaleSeconds'] as num?)?.toInt(),
      fallback: defaults.inhaleSeconds,
    );
    final holdIn = _resolvedPhaseValue(
      value: (json['holdInSeconds'] as num?)?.toInt() ?? (json['holdSeconds'] as num?)?.toInt(),
      fallback: defaults.holdInSeconds,
    );
    final exhale = _resolvedPhaseValue(
      value: (json['exhaleSeconds'] as num?)?.toInt(),
      fallback: defaults.exhaleSeconds,
    );
    final holdOut = _resolvedPhaseValue(
      value: (json['holdOutSeconds'] as num?)?.toInt() ?? (json['restSeconds'] as num?)?.toInt(),
      fallback: defaults.holdOutSeconds,
    );

    return BreathingSettingsModel(
      breathDurationSeconds: breathDurationSeconds,
      rounds: rounds,
      advancedTimingEnabled: advancedTimingEnabled,
      inhaleSeconds: inhale,
      holdInSeconds: holdIn,
      exhaleSeconds: exhale,
      holdOutSeconds: holdOut,
      soundEnabled: json['soundEnabled'] as bool? ?? defaults.soundEnabled,
    );
  }

  final int breathDurationSeconds;
  final int rounds;
  final bool advancedTimingEnabled;
  final int inhaleSeconds;
  final int holdInSeconds;
  final int exhaleSeconds;
  final int holdOutSeconds;
  final bool soundEnabled;

  BreathingSettings toEntity() {
    return BreathingSettings(
      breathDurationSeconds: breathDurationSeconds,
      rounds: rounds,
      advancedTimingEnabled: advancedTimingEnabled,
      inhaleSeconds: inhaleSeconds,
      holdInSeconds: holdInSeconds,
      exhaleSeconds: exhaleSeconds,
      holdOutSeconds: holdOutSeconds,
      soundEnabled: soundEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'breathDurationSeconds': breathDurationSeconds,
      'rounds': rounds,
      'advancedTimingEnabled': advancedTimingEnabled,
      'inhaleSeconds': inhaleSeconds,
      'holdInSeconds': holdInSeconds,
      'exhaleSeconds': exhaleSeconds,
      'holdOutSeconds': holdOutSeconds,
      'soundEnabled': soundEnabled,
    };
  }

  static int _resolvedPhaseValue({
    required int? value,
    required int fallback,
  }) {
    if (value == null) {
      return fallback;
    }

    if (value < BreathingSettings.minPhaseSeconds || value > BreathingSettings.maxPhaseSeconds) {
      return fallback;
    }

    return value;
  }
}
