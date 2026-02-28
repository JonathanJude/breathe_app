import 'package:equatable/equatable.dart';

abstract class BreathingEvent extends Equatable {
  const BreathingEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadSettings extends BreathingEvent {
  const LoadSettings();
}

class UpdateSetting extends BreathingEvent {
  const UpdateSetting({
    this.breathDurationSeconds,
    this.rounds,
    this.advancedTimingEnabled,
    this.inhaleSeconds,
    this.holdInSeconds,
    this.exhaleSeconds,
    this.holdOutSeconds,
    this.soundEnabled,
  });

  final int? breathDurationSeconds;
  final int? rounds;
  final bool? advancedTimingEnabled;
  final int? inhaleSeconds;
  final int? holdInSeconds;
  final int? exhaleSeconds;
  final int? holdOutSeconds;
  final bool? soundEnabled;

  @override
  List<Object?> get props => <Object?>[
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

class StartSession extends BreathingEvent {
  const StartSession();
}

class Pause extends BreathingEvent {
  const Pause();
}

class Resume extends BreathingEvent {
  const Resume();
}

class Cancel extends BreathingEvent {
  const Cancel();
}

class Complete extends BreathingEvent {
  const Complete();
}
