import 'package:breathe_app/app/router/app_router.dart';
import 'package:breathe_app/core/theme/app_durations.dart';
import 'package:breathe_app/core/widgets/app_scaffold.dart';
import 'package:breathe_app/core/widgets/page_top_controls.dart';
import 'package:breathe_app/features/breathing/domain/entities/breathing_phase.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:breathe_app/features/breathing/presentation/widgets/session_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SessionPage extends StatelessWidget {
  static const String routeName = '/session';

  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.sizeOf(context).width >= 900;

    return BlocListener<BreathingBloc, BreathingState>(
      listenWhen: (previous, current) => current is BreathingCompleted,
      listener: (context, state) {
        context.go(AppRoutes.finish);
      },
      child: AppScaffold(
        child: BlocBuilder<BreathingBloc, BreathingState>(
          builder: (context, state) {
            Widget body;
            if (state is BreathingPreparing) {
              body = BreathingGetReadyContent(
                remainingSeconds: state.remainingSeconds,
              );
            } else {
              final snapshot = state.session;
              if (snapshot == null) {
                body = Center(
                  key: const ValueKey<String>('start-session'),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<BreathingBloc>().add(const StartSession());
                    },
                    child: const Text('Start session'),
                  ),
                );
              } else {
                final descriptor = snapshot.currentPhase.descriptor;
                final isPaused = state is BreathingPaused;

                body = BreathingActiveSessionContent(
                  phaseAnimationKey:
                      '${snapshot.currentRound}_${snapshot.currentPhase.name}',
                  bubbleStartScale: _bubbleStartScale(snapshot.currentPhase),
                  bubbleEndScale: _bubbleEndScale(snapshot.currentPhase),
                  bubbleAnimationDuration: _bubbleAnimationDuration(
                    snapshot.currentPhase,
                    snapshot.phaseDurationSeconds,
                  ),
                  bubbleLabel: _bubbleLabel(snapshot),
                  title: descriptor.title,
                  subtitle: descriptor.subtitle,
                  progress: snapshot.progress,
                  cycleLabel:
                      'Cycle ${snapshot.currentRound} of ${snapshot.totalRounds}',
                  pauseLabel: isPaused ? 'Resume' : 'Pause',
                  isPaused: isPaused,
                  isWeb: isWeb,
                  onPauseToggle: () {
                    context.read<BreathingBloc>().add(
                      isPaused ? const Resume() : const Pause(),
                    );
                  },
                );
              }
            }

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                isWeb ? 24 : 16,
                isWeb ? 10 : 8,
                isWeb ? 24 : 16,
                18,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isWeb ? 560 : 430),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      PageTopControls(
                        showLeading: true,
                        padding: EdgeInsets.zero,
                        onLeadingTap: () {
                          context.read<BreathingBloc>().add(const Cancel());
                          context.go(AppRoutes.setup);
                        },
                      ),
                      AnimatedSwitcher(
                        duration: AppDurations.medium,
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (transitionChild, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: transitionChild,
                          );
                        },
                        child: body,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static const double _expandedScale = 1;
  static const double _shrunkScale = 0.54;

  double _bubbleStartScale(BreathingPhase phase) {
    return switch (phase) {
      BreathingPhase.inhale => _expandedScale,
      BreathingPhase.holdIn => _shrunkScale,
      BreathingPhase.exhale => _shrunkScale,
      BreathingPhase.holdOut => _expandedScale,
    };
  }

  double _bubbleEndScale(BreathingPhase phase) {
    return switch (phase) {
      BreathingPhase.inhale => _shrunkScale,
      BreathingPhase.holdIn => _shrunkScale,
      BreathingPhase.exhale => _expandedScale,
      BreathingPhase.holdOut => _expandedScale,
    };
  }

  String? _bubbleLabel(BreathingSessionSnapshot snapshot) {
    final phase = snapshot.currentPhase;
    if (phase.isHold) {
      return null;
    }

    if (phase == BreathingPhase.inhale) {
      return snapshot.secondInPhase.toString();
    }

    return (snapshot.phaseDurationSeconds - snapshot.secondInPhase + 1)
        .toString();
  }

  Duration _bubbleAnimationDuration(
    BreathingPhase phase,
    int phaseDurationSeconds,
  ) {
    if (phase == BreathingPhase.holdIn || phase == BreathingPhase.holdOut) {
      return AppDurations.normal;
    }

    if (phaseDurationSeconds <= 1) {
      return AppDurations.fast;
    }

    return AppDurations.breathingPhase(phaseDurationSeconds);
  }
}
