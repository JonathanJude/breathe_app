import 'package:breathe_app/core/widgets/page_top_controls.dart';
import 'package:breathe_app/core/widgets/primary_button.dart';
import 'package:breathe_app/core/widgets/scene_scaffold.dart';
import 'package:breathe_app/features/session/session_page.dart';
import 'package:breathe_app/features/setup/widgets/setup_palette.dart';
import 'package:breathe_app/features/setup/widgets/setup_settings_card.dart';
import 'package:breathe_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  static const int _minSeconds = 2;
  static const int _maxSeconds = 10;

  int _selectedBreathDuration = 4;
  int _selectedRound = 4;
  bool _advancedExpanded = true;
  bool _soundEnabled = true;
  final Map<String, int> _phaseDurations = <String, int>{
    'Breathe in': 4,
    'Hold in': 4,
    'Breathe out': 4,
    'Hold out': 4,
  };

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.sizeOf(context).width >= 900;
    final palette = SetupPalette.fromTheme(Theme.of(context).brightness);

    return SceneScaffold(
      child: SingleChildScrollView(
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
                  "Set your breathing pace",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                  palette: palette,
                  breathDurations: palette.breathDurationOptions,
                  selectedBreathDuration: _selectedBreathDuration,
                  roundOptions: const <int>[2, 4, 6, 8],
                  selectedRound: _selectedRound,
                  advancedExpanded: _advancedExpanded,
                  phaseDurations: _phaseDurations,
                  soundEnabled: _soundEnabled,
                  onBreathDurationSelected: _onBreathDurationSelected,
                  onRoundSelected: (value) {
                    setState(() {
                      _selectedRound = value;
                    });
                  },
                  onToggleAdvanced: () {
                    setState(() {
                      _advancedExpanded = !_advancedExpanded;
                    });
                  },
                  onAdjustPhase: _adjustPhaseDuration,
                  onSoundToggled: (value) {
                    setState(() {
                      _soundEnabled = value;
                    });
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
                        Navigator.of(context).pushNamed(SessionPage.routeName);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onBreathDurationSelected(int value) {
    setState(() {
      _selectedBreathDuration = value;
      for (final key in _phaseDurations.keys) {
        _phaseDurations[key] = value;
      }
    });
  }

  void _adjustPhaseDuration(String phase, int delta) {
    setState(() {
      final current = _phaseDurations[phase] ?? _selectedBreathDuration;
      final next = (current + delta).clamp(_minSeconds, _maxSeconds);
      _phaseDurations[phase] = next;
    });
  }
}
