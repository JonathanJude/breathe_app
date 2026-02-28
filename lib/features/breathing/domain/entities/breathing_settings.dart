import 'package:breathe_app/features/breathing/domain/entities/breathing_phase.dart';
import 'package:equatable/equatable.dart';

class BreathingSettings extends Equatable {
  const BreathingSettings({
    required this.breathDurationSeconds,
    required this.rounds,
    required this.advancedTimingEnabled,
    required this.inhaleSeconds,
    required this.holdInSeconds,
    required this.exhaleSeconds,
    required this.holdOutSeconds,
    required this.soundEnabled,
  });

  static const List<int> breathDurationOptions = <int>[3, 4, 5, 6];
  static const List<int> roundOptions = <int>[2, 4, 6, 8];
  static const int minPhaseSeconds = 2;
  static const int maxPhaseSeconds = 10;

  static const BreathingSettings defaults = BreathingSettings(
    breathDurationSeconds: 4,
    rounds: 4,
    advancedTimingEnabled: false,
    inhaleSeconds: 4,
    holdInSeconds: 4,
    exhaleSeconds: 4,
    holdOutSeconds: 4,
    soundEnabled: true,
  );

  final int breathDurationSeconds;
  final int rounds;
  final bool advancedTimingEnabled;
  final int inhaleSeconds;
  final int holdInSeconds;
  final int exhaleSeconds;
  final int holdOutSeconds;
  final bool soundEnabled;

  int phaseSeconds(BreathingPhase phase) {
    if (!advancedTimingEnabled) {
      return breathDurationSeconds;
    }

    return switch (phase) {
      BreathingPhase.inhale => inhaleSeconds,
      BreathingPhase.holdIn => holdInSeconds,
      BreathingPhase.exhale => exhaleSeconds,
      BreathingPhase.holdOut => holdOutSeconds,
    };
  }

  int get cycleSeconds {
    return phaseSeconds(BreathingPhase.inhale) +
        phaseSeconds(BreathingPhase.holdIn) +
        phaseSeconds(BreathingPhase.exhale) +
        phaseSeconds(BreathingPhase.holdOut);
  }

  int get totalSessionSeconds => cycleSeconds * rounds;

  String roundLabel(int value) {
    return switch (value) {
      2 => 'quick',
      4 => 'calm',
      6 => 'deep',
      8 => 'zen',
      _ => '$value',
    };
  }

  BreathingSettings copyWith({
    int? breathDurationSeconds,
    int? rounds,
    bool? advancedTimingEnabled,
    int? inhaleSeconds,
    int? holdInSeconds,
    int? exhaleSeconds,
    int? holdOutSeconds,
    bool? soundEnabled,
  }) {
    final resolvedBreathDuration = breathDurationSeconds ?? this.breathDurationSeconds;
    final resolvedAdvanced = advancedTimingEnabled ?? this.advancedTimingEnabled;

    final syncedInhale = resolvedAdvanced ? (inhaleSeconds ?? this.inhaleSeconds) : resolvedBreathDuration;
    final syncedHoldIn = resolvedAdvanced ? (holdInSeconds ?? this.holdInSeconds) : resolvedBreathDuration;
    final syncedExhale = resolvedAdvanced ? (exhaleSeconds ?? this.exhaleSeconds) : resolvedBreathDuration;
    final syncedHoldOut = resolvedAdvanced ? (holdOutSeconds ?? this.holdOutSeconds) : resolvedBreathDuration;

    return BreathingSettings(
      breathDurationSeconds: resolvedBreathDuration,
      rounds: rounds ?? this.rounds,
      advancedTimingEnabled: resolvedAdvanced,
      inhaleSeconds: syncedInhale,
      holdInSeconds: syncedHoldIn,
      exhaleSeconds: syncedExhale,
      holdOutSeconds: syncedHoldOut,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }

  @override
  List<Object> get props => <Object>[
    breathDurationSeconds,
    rounds,
    advancedTimingEnabled,
    inhaleSeconds,
    holdInSeconds,
    exhaleSeconds,
    holdOutSeconds,
    soundEnabled,
  ];
}
