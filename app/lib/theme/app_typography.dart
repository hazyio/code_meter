import 'package:flutter/material.dart';

/// Type scale ported from the original design spec.
/// Uses the platform default font (no custom font bundled) —
/// matches the FontFamily.Default choice made on the Compose side.
class AppTypography {
  AppTypography._();

  static TextTheme textTheme(Color onSurface) {
    return TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 57,
        height: 64 / 57,
        letterSpacing: -0.25,
        color: onSurface,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
        height: 40 / 32,
        letterSpacing: 0,
        color: onSurface,
      ),
      // headline-lg-mobile from the spec — use for compact widths
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        height: 36 / 28,
        letterSpacing: 0,
        color: onSurface,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        height: 28 / 22,
        letterSpacing: 0,
        color: onSurface,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.5,
        color: onSurface,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: onSurface,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: onSurface,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 16 / 11,
        letterSpacing: 0.5,
        color: onSurface,
      ),
    );
  }
}
