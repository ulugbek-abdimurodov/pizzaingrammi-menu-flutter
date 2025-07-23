import 'package:flutter/material.dart';

/// Application color palette following design system
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Brand Colors
  static const Color primary = Color(0xFFEEC80B);
  static const Color primaryDark = Color(0xFFD4B509);
  static const Color primaryLight = Color(0xFFF5D147);

  // Background Colors
  static const Color background = Color(0xFF232010);
  static const Color surface = Color(0xFF494222);
  static const Color surfaceContainer = Color(0xFF342F18);
  static const Color surfaceVariant = Color(0xFF5A4F2A);

  // Text Colors
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFCBC190);
  static const Color textTertiary = Color(0xFF8B8462);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Interactive Colors
  static const Color onPrimary = Color(0xFF000000);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color onWarning = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onInfo = Color(0xFFFFFFFF);

  // Utility Colors
  static const Color divider = Color(0xFF685F31);
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);
  static const Color transparent = Colors.transparent;

  // State Colors
  static const Color disabled = Color(0xFF6B7280);
  static const Color disabledContainer = Color(0xFF374151);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}