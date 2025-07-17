import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Returns true when the current window should be treated as a phone‑sized
/// surface.  Works for native and web.
bool isPhone(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final shortestSide = size.shortestSide;
  const phoneBreakpoint = 600.0; // Material 3 guideline

  // For native Android/iOS, use the shortest side to handle orientation changes
  // and consider devices with shortestSide < 600 as phones (handles large
  // phones like S23 Ultra)
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    return shortestSide < phoneBreakpoint;
  }

  // For web/desktop, use the current width for responsive behavior
  return size.width < phoneBreakpoint;
}
