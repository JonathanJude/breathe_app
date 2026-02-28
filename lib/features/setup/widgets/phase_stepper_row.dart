import 'package:breathe_app/features/setup/widgets/setup_palette.dart';
import 'package:flutter/material.dart';

class PhaseStepperRow extends StatelessWidget {
  const PhaseStepperRow({
    required this.label,
    required this.value,
    required this.palette,
    required this.onDecrement,
    required this.onIncrement,
    super.key,
  });

  final String label;
  final int value;
  final SetupPalette palette;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: palette.phaseRowBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.phaseRowBorder),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                color: palette.phaseRowText,
              ),
            ),
          ),
          _RoundIconButton(
            icon: Icons.remove,
            background: palette.stepperButtonBackground,
            foreground: palette.stepperButtonForeground,
            onTap: onDecrement,
          ),
          const SizedBox(width: 14),
          Text(
            '${value}s',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              color: palette.phaseRowText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 14),
          _RoundIconButton(
            icon: Icons.add,
            background: palette.stepperButtonBackground,
            foreground: palette.stepperButtonForeground,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 30,
          height: 30,
          child: Icon(icon, size: 20, color: foreground),
        ),
      ),
    );
  }
}
