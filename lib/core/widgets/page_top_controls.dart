import 'package:breathe_app/core/theme/theme_cubit.dart';
import 'package:breathe_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageTopControls extends StatelessWidget {
  const PageTopControls({
    super.key,
    this.showLeading = true,
    this.onLeadingTap,
    this.padding,
  });

  final bool showLeading;
  final VoidCallback? onLeadingTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (showLeading)
                _ControlButton(
                  icon: Icons.close,
                  onTap: onLeadingTap ?? () => Navigator.maybePop(context),
                )
              else
                const SizedBox(width: 56, height: 56),
              _ControlButton(
                icon: isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.controlDark
              : AppColors.controlLight.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28,
          color: isDark ? Colors.white : Colors.black.withValues(alpha: 0.82),
        ),
      ),
    );
  }
}
