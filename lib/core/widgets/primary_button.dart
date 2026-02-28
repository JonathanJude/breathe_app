import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.trailingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 56,
    this.borderRadius = const BorderRadius.all(Radius.circular(35)),
    this.textStyle,
    this.iconSpacing = 10,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final TextStyle? textStyle;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size.fromHeight(height),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle:
            textStyle ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      onPressed: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
    );
  }
}
