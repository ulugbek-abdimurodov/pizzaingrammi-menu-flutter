import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color background = Color(0xFF232010);
  static const Color cardBackground = Color(0xFF494222);
  static const Color bottomNavBackground = Color(0xFF342F18);
  static const Color accent = Color(0xFFEEC80B);
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFCBC190);
  
  // Additional colors
  static const Color divider = Color(0xFF685F31);
  static const Color buttonSecondary = Color(0xFF5A4F2A);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accent, Color(0xFFD4B509)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}