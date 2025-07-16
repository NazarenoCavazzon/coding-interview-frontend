import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_theme.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.child,
    super.key,
    this.title,
    this.backgroundColor,
    this.borderRadius,
    this.handleColor,
    this.titleStyle,
    this.padding,
  });

  final Widget child;
  final String? title;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? handleColor;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius:
            borderRadius ??
            const BorderRadius.vertical(
              top: Radius.circular(AppTheme.borderRadiusLarge),
            ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
            width: 64,
            height: 5,
            decoration: BoxDecoration(
              color: handleColor ?? Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
            ),
          ),
          if (title != null) ...[
            Text(
              title!,
              style: titleStyle ?? Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppTheme.spacingMedium),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Color? handleColor,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? padding,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) => AppBottomSheet(
        title: title,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        handleColor: handleColor,
        titleStyle: titleStyle,
        padding: padding,
        child: child,
      ),
    );
  }
}

class AppBottomSheetItem extends StatelessWidget {
  const AppBottomSheetItem({
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
              const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
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
