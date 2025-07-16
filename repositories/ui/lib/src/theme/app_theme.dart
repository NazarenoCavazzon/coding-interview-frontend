import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Light Theme Colors
  static const Color _lightPrimaryColor = Color(0xFFE8A317);
  static const Color _lightBackgroundColor = Colors.white;
  static const Color _lightSurfaceColor = Colors.white;
  static const Color _lightTextPrimary = Color(0xFF1A1A1A);
  static const Color _lightTextSecondary = Color(0xFF333333);
  static const Color _lightTextTertiary = Color(0xFF666666);
  static const Color _lightBorderPrimary = Color(0xFFE8A317);
  static const Color _lightBorderSecondary = Color(0xFFededed);
  static const Color _lightCardBackground = Colors.white;
  static const Color _lightScaffoldBackground = Color(0xFFDEF8FA);

  // Dark Theme Colors
  static const Color _darkPrimaryColor = Color(0xFFE8A317);
  static const Color _darkBackgroundColor = Color(0xFF1A1A1A);
  static const Color _darkSurfaceColor = Color(0xFF2D2D2D);
  static const Color _darkTextPrimary = Color(0xFFFFFFFF);
  static const Color _darkTextSecondary = Color(0xFFE0E0E0);
  static const Color _darkTextTertiary = Color(0xFFB0B0B0);
  static const Color _darkBorderPrimary = Color(0xFFE8A317);
  static const Color _darkCardBackground = Color(0xFF2D2D2D);
  static const Color _darkScaffoldBackground = Color(0xFF1A1A1A);

  // Legacy Colors (for backward compatibility)
  static const Color primaryColor = _lightPrimaryColor;
  static const Color backgroundColor = _lightBackgroundColor;
  static const Color surfaceColor = _lightSurfaceColor;
  static const Color textPrimary = _lightTextPrimary;
  static const Color textSecondary = _lightTextSecondary;
  static const Color textTertiary = _lightTextTertiary;
  static const Color textQuaternary = Color(0xFF656565);
  static const Color textDisabled = Color(0xFFbdc3cb);
  static const Color borderPrimary = _lightBorderPrimary;
  static const Color borderSecondary = _lightBorderSecondary;
  static const Color cardBackground = _lightCardBackground;
  static const Color shadowColor = Colors.black;

  // Light Theme Shimmer Colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Dark Theme Shimmer Colors
  static const Color shimmerBaseDark = Color(0xFF404040);
  static const Color shimmerHighlightDark = Color(0xFF606060);

  // Helper method to get theme-aware shimmer colors
  static Color getShimmerBaseColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? shimmerBase
        : shimmerBaseDark;
  }

  static Color getShimmerHighlightColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? shimmerHighlight
        : shimmerHighlightDark;
  }

  // Light Theme Data
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    scaffoldBackgroundColor: _lightScaffoldBackground,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightPrimaryColor,
      onSecondary: Colors.white,
      onSurface: _lightTextPrimary,
      onBackground: _lightTextPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightScaffoldBackground,
      foregroundColor: _lightTextPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: _lightCardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusLarge),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: _lightBorderPrimary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: _lightBorderPrimary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: _lightBorderPrimary, width: 1.5),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _lightTextSecondary,
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _lightTextSecondary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _lightTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _lightTextSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: _lightTextPrimary,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _lightTextTertiary,
      ),
      labelMedium: TextStyle(fontSize: 14, color: Color(0xFF656565)),
    ),
  );

  // Dark Theme Data
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    scaffoldBackgroundColor: _darkScaffoldBackground,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkPrimaryColor,
      surface: _darkSurfaceColor,
      background: _darkBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkScaffoldBackground,
      foregroundColor: _darkTextPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: _darkCardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusLarge),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimaryColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: _darkBorderPrimary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: _darkBorderPrimary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: _darkBorderPrimary, width: 1.5),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _darkTextSecondary,
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _darkTextSecondary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _darkTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _darkTextSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: _darkTextPrimary,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _darkTextTertiary,
      ),
      labelMedium: TextStyle(fontSize: 14, color: _darkTextTertiary),
    ),
  );

  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textSecondary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textSecondary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textTertiary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    color: textQuaternary,
  );

  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static const TextStyle inputPrefix = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Border Radius
  static const double borderRadiusSmall = 8;
  static const double borderRadiusMedium = 12;
  static const double borderRadiusLarge = 16;
  static const double borderRadiusXLarge = 32;

  // Spacing
  static const double spacingXSmall = 4;
  static const double spacingSmall = 8;
  static const double spacingMedium = 16;
  static const double spacingLarge = 24;
  static const double spacingXLarge = 32;

  // Elevation
  static const double elevationSmall = 2;
  static const double elevationMedium = 4;
  static const double elevationLarge = 8;

  // Input Decoration
  static InputDecoration inputDecoration(
    BuildContext context, {
    String? hintText,
    Widget? prefixIcon,
    Color? borderColor,
    Color? focusedBorderColor,
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
  }) {
    final theme = Theme.of(context);
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      prefixIconConstraints: const BoxConstraints(minWidth: 12),
      prefixIcon: prefixIcon,
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(borderRadiusMedium),
        borderSide: BorderSide(
          color: focusedBorderColor ?? theme.colorScheme.primary,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(borderRadiusMedium),
        borderSide: BorderSide(color: borderColor ?? theme.colorScheme.primary),
      ),
      contentPadding:
          contentPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
