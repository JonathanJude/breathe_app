import 'package:equatable/equatable.dart';

enum BreathingPhase { inhale, holdIn, exhale, holdOut }

class BreathingPhaseDescriptor extends Equatable {
  const BreathingPhaseDescriptor({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  List<Object> get props => <Object>[title, subtitle];
}

extension BreathingPhaseX on BreathingPhase {
  bool get isHold => this == BreathingPhase.holdIn || this == BreathingPhase.holdOut;

  BreathingPhase next() {
    return switch (this) {
      BreathingPhase.inhale => BreathingPhase.holdIn,
      BreathingPhase.holdIn => BreathingPhase.exhale,
      BreathingPhase.exhale => BreathingPhase.holdOut,
      BreathingPhase.holdOut => BreathingPhase.inhale,
    };
  }

  BreathingPhaseDescriptor get descriptor {
    return switch (this) {
      BreathingPhase.inhale => const BreathingPhaseDescriptor(
        title: 'Breathe in',
        subtitle: 'slow and steady',
      ),
      BreathingPhase.holdIn => const BreathingPhaseDescriptor(
        title: 'Hold gently',
        subtitle: 'you are doing great',
      ),
      BreathingPhase.exhale => const BreathingPhaseDescriptor(
        title: 'Breathe out',
        subtitle: 'nice and slow',
      ),
      BreathingPhase.holdOut => const BreathingPhaseDescriptor(
        title: 'Hold softly',
        subtitle: 'just be here',
      ),
    };
  }
}
