import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Returns true when the current window should be treated as a phone‑sized
/// surface.  Works for native and web.
bool isPhone(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width; // Flutter 3.22+
  const phoneBreakpoint = 600.0; // Material 3 guideline

  // For native Android/iOS we still guard against tablets >600 px.
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    return width < phoneBreakpoint;
  }

  // For web/desktop just use the width.
  return width < phoneBreakpoint;
}
