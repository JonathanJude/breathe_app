import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.trailingIcon,
    this.leadingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 56,
    this.borderRadius = const BorderRadius.all(Radius.circular(35)),
    this.textStyle,
    this.iconSpacing = 10,
    this.isExpanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final TextStyle? textStyle;
  final double iconSpacing;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: isExpanded ? Size.fromHeight(height) : Size(0, height),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle:
            textStyle ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (leadingIcon != null) ...<Widget>[
                leadingIcon!,
                SizedBox(width: iconSpacing),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Quicksand',
                ),
              ),
              if (trailingIcon != null) ...<Widget>[
                SizedBox(width: iconSpacing),
                trailingIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
