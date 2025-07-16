import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    super.key,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.disabledColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.elevation,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? elevation;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isEnabled ? onPressed : null,
      disabledColor:
          disabledColor ??
          (backgroundColor ?? AppTheme.primaryColor).withOpacity(0.5),
      hoverColor: hoverColor ?? Colors.transparent,
      highlightColor: highlightColor ?? Colors.transparent,
      elevation: elevation ?? AppTheme.elevationSmall,
      focusElevation: elevation ?? AppTheme.elevationSmall,
      hoverElevation: elevation ?? AppTheme.elevationSmall,
      highlightElevation: 0,
      splashColor: splashColor ?? Colors.white.withOpacity(0.1),
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppTheme.borderRadiusMedium),
      ),
      color: backgroundColor ?? AppTheme.primaryColor,
      textColor: textColor ?? Colors.white,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
      child: Text(title, style: textStyle ?? AppTheme.buttonText),
    );
  }
}
