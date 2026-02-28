import 'package:breathe_app/app/router/app_router.dart';
import 'package:breathe_app/core/widgets/app_scaffold.dart';
import 'package:breathe_app/core/widgets/page_top_controls.dart';
import 'package:breathe_app/core/widgets/primary_button.dart';
import 'package:breathe_app/features/breathing/domain/entities/breathing_settings.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_event.dart';
import 'package:breathe_app/features/breathing/presentation/bloc/breathing_state.dart';
import 'package:breathe_app/features/breathing/presentation/widgets/app_pallete.dart';
import 'package:breathe_app/features/breathing/presentation/widgets/setup_settings_card.dart';
import 'package:breathe_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.sizeOf(context).width >= 900;
    final palette = context.appPallete;

    return AppScaffold(
      child: BlocBuilder<BreathingBloc, BreathingState>(
        builder: (context, state) {
          final settings = state.settings;
          final phaseDurations = <String, int>{
            'Breathe in': settings.inhaleSeconds,
            'Hold in': settings.holdInSeconds,
            'Breathe out': settings.exhaleSeconds,
            'Hold out': settings.holdOutSeconds,
          };

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isWeb ? 0 : 22,
              isWeb ? 14 : 8,
              isWeb ? 0 : 22,
              24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isWeb ? 460 : 430),
                child: Column(
                  children: <Widget>[
                    PageTopControls(
                      showLeading: false,
                      padding: EdgeInsets.fromLTRB(
                        isWeb ? 24 : 0,
                        isWeb ? 0 : 8,
                        isWeb ? 24 : 0,
                        0,
                      ),
                    ),
                    SizedBox(height: isWeb ? 8 : 12),
                    Text(
                      'Set your breathing pace',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontSize: isWeb ? 48 : 24,
                            color: palette.pageTitleColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Customise your breathing session. You\ncan always change this later.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: isWeb ? 20 : 14,
                        height: 1.45,
                        color: palette.subtitle,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isWeb ? 24 : 26),
                    SetupSettingsCard(
                      breathDurations: BreathingSettings.breathDurationOptions,
                      selectedBreathDuration: settings.breathDurationSeconds,
                      roundOptions: BreathingSettings.roundOptions,
                      selectedRound: settings.rounds,
                      advancedExpanded: settings.advancedTimingEnabled,
                      phaseDurations: phaseDurations,
                      soundEnabled: settings.soundEnabled,
                      onBreathDurationSelected: (value) {
                        context.read<BreathingBloc>().add(
                          UpdateSetting(breathDurationSeconds: value),
                        );
                      },
                      onRoundSelected: (value) {
                        context.read<BreathingBloc>().add(
                          UpdateSetting(rounds: value),
                        );
                      },
                      onToggleAdvanced: () {
                        context.read<BreathingBloc>().add(
                          UpdateSetting(
                            advancedTimingEnabled:
                                !settings.advancedTimingEnabled,
                          ),
                        );
                      },
                      onAdjustPhase: (phase, delta) {
                        _onAdjustPhase(context, settings, phase, delta);
                      },
                      onSoundToggled: (value) {
                        context.read<BreathingBloc>().add(
                          UpdateSetting(soundEnabled: value),
                        );
                      },
                    ),
                    SizedBox(height: isWeb ? 22 : 26),
                    SizedBox(
                      width: isWeb ? 250 : double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: PrimaryButton(
                          label: 'Start breathing',
                          backgroundColor: palette.primaryButton,
                          foregroundColor: palette.primaryButtonText,
                          height: isWeb ? 54 : 58,
                          trailingIcon: Assets.icons.svg.fastWind.svg(),
                          onPressed: () {
                            context.read<BreathingBloc>().add(
                              const StartSession(),
                            );
                            context.go(AppRoutes.session);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onAdjustPhase(
    BuildContext context,
    BreathingSettings settings,
    String phase,
    int delta,
  ) {
    final update = switch (phase) {
      'Breathe in' => UpdateSetting(
        inhaleSeconds: _phaseStep(settings.inhaleSeconds, delta),
      ),
      'Hold in' => UpdateSetting(
        holdInSeconds: _phaseStep(settings.holdInSeconds, delta),
      ),
      'Breathe out' => UpdateSetting(
        exhaleSeconds: _phaseStep(settings.exhaleSeconds, delta),
      ),
      'Hold out' => UpdateSetting(
        holdOutSeconds: _phaseStep(settings.holdOutSeconds, delta),
      ),
      _ => null,
    };

    if (update != null) {
      context.read<BreathingBloc>().add(update);
    }
  }

  int _phaseStep(int current, int delta) {
    final next = current + delta;
    if (next < BreathingSettings.minPhaseSeconds) {
      return BreathingSettings.minPhaseSeconds;
    }
    if (next > BreathingSettings.maxPhaseSeconds) {
      return BreathingSettings.maxPhaseSeconds;
    }
    return next;
  }
}
