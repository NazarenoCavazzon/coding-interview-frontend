import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_theme.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.child,
    super.key,
    this.title,
    this.backgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.padding,
    this.width,
    this.height,
  });

  final Widget child;
  final String? title;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width ?? 320,
        height: height,
        padding: padding ?? const EdgeInsets.all(AppTheme.spacingLarge),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius:
              borderRadius ??
              BorderRadius.circular(AppTheme.borderRadiusMedium),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style:
                        titleStyle ?? Theme.of(context).textTheme.headlineLarge,
                  ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        titleStyle: titleStyle,
        padding: padding,
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class AppDialogItem extends StatelessWidget {
  const AppDialogItem({
    required this.title,
    required this.onTap,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.isSelected = false,
    this.titleStyle,
    this.subtitleStyle,
    this.selectedColor,
    this.padding,
  });

  final String title;
  final VoidCallback onTap;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool isSelected;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color? selectedColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppTheme.spacingMedium),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          titleStyle ??
                          Theme.of(context).textTheme.headlineMedium,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style:
                            subtitleStyle ??
                            Theme.of(context).textTheme.labelMedium,
                      ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AppTheme.spacingMedium),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
