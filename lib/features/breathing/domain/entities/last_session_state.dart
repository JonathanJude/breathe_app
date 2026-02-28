import 'package:breathe_app/features/breathing/domain/entities/breathing_phase.dart';
import 'package:equatable/equatable.dart';

class LastSessionState extends Equatable {
  const LastSessionState({
    required this.currentRound,
    required this.totalRounds,
    required this.currentPhase,
    required this.secondInPhase,
    required this.phaseDurationSeconds,
    required this.elapsedSessionSeconds,
    required this.totalSessionSeconds,
    required this.isPaused,
    required this.updatedAtEpochMillis,
  });

  final int currentRound;
  final int totalRounds;
  final BreathingPhase currentPhase;
  final int secondInPhase;
  final int phaseDurationSeconds;
  final int elapsedSessionSeconds;
  final int totalSessionSeconds;
  final bool isPaused;
  final int updatedAtEpochMillis;

  bool get hasRemaining => elapsedSessionSeconds < totalSessionSeconds;

  @override
  List<Object> get props => <Object>[
    currentRound,
    totalRounds,
    currentPhase,
    secondInPhase,
    phaseDurationSeconds,
    elapsedSessionSeconds,
    totalSessionSeconds,
    isPaused,
    updatedAtEpochMillis,
  ];
}
