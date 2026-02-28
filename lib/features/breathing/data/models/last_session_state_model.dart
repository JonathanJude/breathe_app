import 'package:breathe_app/features/breathing/domain/entities/breathing_phase.dart';
import 'package:breathe_app/features/breathing/domain/entities/last_session_state.dart';

class LastSessionStateModel {
  const LastSessionStateModel({
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

  factory LastSessionStateModel.fromEntity(LastSessionState entity) {
    return LastSessionStateModel(
      currentRound: entity.currentRound,
      totalRounds: entity.totalRounds,
      currentPhase: entity.currentPhase,
      secondInPhase: entity.secondInPhase,
      phaseDurationSeconds: entity.phaseDurationSeconds,
      elapsedSessionSeconds: entity.elapsedSessionSeconds,
      totalSessionSeconds: entity.totalSessionSeconds,
      isPaused: entity.isPaused,
      updatedAtEpochMillis: entity.updatedAtEpochMillis,
    );
  }

  factory LastSessionStateModel.fromJson(Map<String, dynamic> json) {
    return LastSessionStateModel(
      currentRound: (json['currentRound'] as num?)?.toInt() ?? 1,
      totalRounds: (json['totalRounds'] as num?)?.toInt() ?? 1,
      currentPhase: _phaseFromName(json['currentPhase'] as String?),
      secondInPhase: (json['secondInPhase'] as num?)?.toInt() ?? 1,
      phaseDurationSeconds: (json['phaseDurationSeconds'] as num?)?.toInt() ?? 1,
      elapsedSessionSeconds: (json['elapsedSessionSeconds'] as num?)?.toInt() ?? 0,
      totalSessionSeconds: (json['totalSessionSeconds'] as num?)?.toInt() ?? 1,
      isPaused: json['isPaused'] as bool? ?? false,
      updatedAtEpochMillis: (json['updatedAtEpochMillis'] as num?)?.toInt() ?? 0,
    );
  }

  final int currentRound;
  final int totalRounds;
  final BreathingPhase currentPhase;
  final int secondInPhase;
  final int phaseDurationSeconds;
  final int elapsedSessionSeconds;
  final int totalSessionSeconds;
  final bool isPaused;
  final int updatedAtEpochMillis;

  LastSessionState toEntity() {
    return LastSessionState(
      currentRound: currentRound,
      totalRounds: totalRounds,
      currentPhase: currentPhase,
      secondInPhase: secondInPhase,
      phaseDurationSeconds: phaseDurationSeconds,
      elapsedSessionSeconds: elapsedSessionSeconds,
      totalSessionSeconds: totalSessionSeconds,
      isPaused: isPaused,
      updatedAtEpochMillis: updatedAtEpochMillis,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'currentRound': currentRound,
      'totalRounds': totalRounds,
      'currentPhase': currentPhase.name,
      'secondInPhase': secondInPhase,
      'phaseDurationSeconds': phaseDurationSeconds,
      'elapsedSessionSeconds': elapsedSessionSeconds,
      'totalSessionSeconds': totalSessionSeconds,
      'isPaused': isPaused,
      'updatedAtEpochMillis': updatedAtEpochMillis,
    };
  }

  static BreathingPhase _phaseFromName(String? phaseName) {
    return BreathingPhase.values.firstWhere(
      (phase) => phase.name == phaseName,
      orElse: () => BreathingPhase.inhale,
    );
  }
}
