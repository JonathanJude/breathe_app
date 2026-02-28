import 'package:breathe_app/features/breathing/presentation/widgets/phase_stepper_row.dart';
import 'package:breathe_app/features/breathing/presentation/widgets/setup_option_chip.dart';
import 'package:breathe_app/features/breathing/presentation/widgets/app_pallete.dart';
import 'package:flutter/material.dart';

class SetupSettingsCard extends StatelessWidget {
  const SetupSettingsCard({
    required this.breathDurations,
    required this.selectedBreathDuration,
    required this.roundOptions,
    required this.selectedRound,
    required this.advancedExpanded,
    required this.phaseDurations,
    required this.soundEnabled,
    required this.onBreathDurationSelected,
    required this.onRoundSelected,
    required this.onToggleAdvanced,
    required this.onAdjustPhase,
    required this.onSoundToggled,
    super.key,
  });

  final List<int> breathDurations;
  final int selectedBreathDuration;
  final List<int> roundOptions;
  final int selectedRound;
  final bool advancedExpanded;
  final Map<String, int> phaseDurations;
  final bool soundEnabled;
  final ValueChanged<int> onBreathDurationSelected;
  final ValueChanged<int> onRoundSelected;
  final VoidCallback onToggleAdvanced;
  final void Function(String phase, int delta) onAdjustPhase;
  final ValueChanged<bool> onSoundToggled;

  @override
  Widget build(BuildContext context) {
    final palette = context.appPallete;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
      decoration: BoxDecoration(
        color: palette.cardBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            title: 'Breath duration',
            subtitle: 'Seconds per phase',
          ),
          const SizedBox(height: 14),
          _OptionRow<int>(
            values: breathDurations,
            selectedValue: selectedBreathDuration,
            labelBuilder: (value) => '${value}s',
            onTap: onBreathDurationSelected,
          ),
          _Divider(color: palette.divider),
          _SectionTitle(
            title: 'Rounds',
            subtitle: 'Full box breathing cycles',
          ),
          const SizedBox(height: 14),
          _OptionRow<int>(
            values: roundOptions,
            selectedValue: selectedRound,
            labelBuilder: (value) => '$value ${_roundLabel(value)}',
            onTap: onRoundSelected,
          ),
          _Divider(color: palette.divider),
          InkWell(
            onTap: onToggleAdvanced,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _SectionTitle(
                      title: 'Advanced timing',
                      subtitle: 'Set different durations for each phase',
                    ),
                  ),
                  Icon(
                    advancedExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: palette.subtitle,
                  ),
                ],
              ),
            ),
          ),
          if (advancedExpanded) ...<Widget>[
            const SizedBox(height: 10),
            ...phaseDurations.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PhaseStepperRow(
                  label: entry.key,
                  value: entry.value,
                  onDecrement: () => onAdjustPhase(entry.key, -1),
                  onIncrement: () => onAdjustPhase(entry.key, 1),
                ),
              );
            }),
            const SizedBox(height: 10),
          ] else ...<Widget>[const SizedBox(height: 20)],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _SectionTitle(
                  title: 'Sound',
                  subtitle: 'Gentle chime between phases',
                ),
              ),
              const SizedBox(width: 14),
              Transform.scale(
                scale: 0.95,
                child: Switch(
                  value: soundEnabled,
                  activeTrackColor: palette.soundTrack,
                  activeThumbColor: palette.soundThumb,
                  inactiveThumbColor: palette.soundThumb,
                  inactiveTrackColor: palette.chipBackground,
                  onChanged: onSoundToggled,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _roundLabel(int rounds) {
    return switch (rounds) {
      2 => 'quick',
      4 => 'calm',
      6 => 'deep',
      8 => 'zen',
      _ => '$rounds',
    };
  }
}

class _OptionRow<T> extends StatelessWidget {
  const _OptionRow({
    required this.values,
    required this.selectedValue,
    required this.labelBuilder,
    required this.onTap,
  });

  final List<T> values;
  final T selectedValue;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onTap;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: values
            .map((value) {
              final selected = value == selectedValue;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SetupOptionChip(
                  label: labelBuilder(value),
                  selected: selected,
                  onTap: () => onTap(value),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final palette = context.appPallete;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 15,
            color: palette.title,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            color: palette.subtitle,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: color),
    );
  }
}
