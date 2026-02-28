import 'package:breathe_app/features/setup/widgets/setup_palette.dart';
import 'package:flutter/material.dart';

class SetupOptionChip extends StatelessWidget {
  const SetupOptionChip({
    required this.label,
    required this.selected,
    required this.palette,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final SetupPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 22),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? palette.chipSelectedBackground
              : palette.chipBackground,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: selected ? palette.chipSelectedBorder : Colors.transparent,
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? palette.chipSelectedText : palette.chipText,
          ),
        ),
      ),
    );
  }
}
