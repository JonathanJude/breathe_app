import 'package:breathe_app/features/breathing/domain/entities/breathing_phase.dart';
import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';
import 'package:breathe_app/features/breathing/domain/entities/last_session_state.dart';
import 'package:equatable/equatable.dart';

abstract class BreathingState extends Equatable {
  const BreathingState();

  @override
  List<Object?> get props => <Object?>[];
}

class BreathingInitial extends BreathingState {
  const BreathingInitial();
}

class BreathingLoading extends BreathingState {
  const BreathingLoading();
}

class BreathingReady extends BreathingState {
  const BreathingReady({
    required this.settings,
    this.lastSessionState,
  });

  final BreathingSettings settings;
  final LastSessionState? lastSessionState;

  @override
  List<Object?> get props => <Object?>[settings, lastSessionState];
}

class BreathingPreparing extends BreathingState {
  const BreathingPreparing({
    required this.settings,
    required this.remainingSeconds,
  });

  final BreathingSettings settings;
  final int remainingSeconds;

  @override
  List<Object> get props => <Object>[settings, remainingSeconds];
}

class BreathingRunning extends BreathingState {
  const BreathingRunning({
    required this.settings,
    required this.currentRound,
    required this.totalRounds,
    required this.currentPhase,
    required this.secondInPhase,
    required this.phaseDurationSeconds,
    required this.elapsedSessionSeconds,
    required this.totalSessionSeconds,
  });

  final BreathingSettings settings;
  final int currentRound;
  final int totalRounds;
  final BreathingPhase currentPhase;
  final int secondInPhase;
  final int phaseDurationSeconds;
  final int elapsedSessionSeconds;
  final int totalSessionSeconds;

  @override
  List<Object> get props => <Object>[
    settings,
    currentRound,
    totalRounds,
    currentPhase,
    secondInPhase,
    phaseDurationSeconds,
    elapsedSessionSeconds,
    totalSessionSeconds,
  ];
}

class BreathingPaused extends BreathingState {
  const BreathingPaused({
    required this.settings,
    required this.currentRound,
    required this.totalRounds,
    required this.currentPhase,
    required this.secondInPhase,
    required this.phaseDurationSeconds,
    required this.elapsedSessionSeconds,
    required this.totalSessionSeconds,
  });

  final BreathingSettings settings;
  final int currentRound;
  final int totalRounds;
  final BreathingPhase currentPhase;
  final int secondInPhase;
  final int phaseDurationSeconds;
  final int elapsedSessionSeconds;
  final int totalSessionSeconds;

  @override
  List<Object> get props => <Object>[
    settings,
    currentRound,
    totalRounds,
    currentPhase,
    secondInPhase,
    phaseDurationSeconds,
    elapsedSessionSeconds,
    totalSessionSeconds,
  ];
}

class BreathingCompleted extends BreathingState {
  const BreathingCompleted({
    required this.settings,
    required this.completedRounds,
    required this.totalSessionSeconds,
  });

  final BreathingSettings settings;
  final int completedRounds;
  final int totalSessionSeconds;

  @override
  List<Object> get props => <Object>[settings, completedRounds, totalSessionSeconds];
}

class BreathingSessionSnapshot extends Equatable {
  const BreathingSessionSnapshot({
    required this.settings,
    required this.currentRound,
    required this.totalRounds,
    required this.currentPhase,
    required this.secondInPhase,
    required this.phaseDurationSeconds,
    required this.elapsedSessionSeconds,
    required this.totalSessionSeconds,
  });

  final BreathingSettings settings;
  final int currentRound;
  final int totalRounds;
  final BreathingPhase currentPhase;
  final int secondInPhase;
  final int phaseDurationSeconds;
  final int elapsedSessionSeconds;
  final int totalSessionSeconds;

  double get progress => totalSessionSeconds <= 0 ? 0 : elapsedSessionSeconds / totalSessionSeconds;

  @override
  List<Object> get props => <Object>[
    settings,
    currentRound,
    totalRounds,
    currentPhase,
    secondInPhase,
    phaseDurationSeconds,
    elapsedSessionSeconds,
    totalSessionSeconds,
  ];
}

extension BreathingStateX on BreathingState {
  BreathingSettings get settings {
    return switch (this) {
      BreathingReady(:final settings) => settings,
      BreathingPreparing(:final settings) => settings,
      BreathingRunning(:final settings) => settings,
      BreathingPaused(:final settings) => settings,
      BreathingCompleted(:final settings) => settings,
      _ => BreathingSettings.defaults,
    };
  }

  BreathingSessionSnapshot? get session {
    return switch (this) {
      BreathingRunning(
        :final settings,
        :final currentRound,
        :final totalRounds,
        :final currentPhase,
        :final secondInPhase,
        :final phaseDurationSeconds,
        :final elapsedSessionSeconds,
        :final totalSessionSeconds,
      ) =>
        BreathingSessionSnapshot(
          settings: settings,
          currentRound: currentRound,
          totalRounds: totalRounds,
          currentPhase: currentPhase,
          secondInPhase: secondInPhase,
          phaseDurationSeconds: phaseDurationSeconds,
          elapsedSessionSeconds: elapsedSessionSeconds,
          totalSessionSeconds: totalSessionSeconds,
        ),
      BreathingPaused(
        :final settings,
        :final currentRound,
        :final totalRounds,
        :final currentPhase,
        :final secondInPhase,
        :final phaseDurationSeconds,
        :final elapsedSessionSeconds,
        :final totalSessionSeconds,
      ) =>
        BreathingSessionSnapshot(
          settings: settings,
          currentRound: currentRound,
          totalRounds: totalRounds,
          currentPhase: currentPhase,
          secondInPhase: secondInPhase,
          phaseDurationSeconds: phaseDurationSeconds,
          elapsedSessionSeconds: elapsedSessionSeconds,
          totalSessionSeconds: totalSessionSeconds,
        ),
      _ => null,
    };
  }
}
