import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'component_themes.dart';

/// Main theme configuration that assembles all theme components
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
        // Base Configuration
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        
        // Font Family
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        
        // Color Scheme
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.primary,
          onSecondary: AppColors.onPrimary,
          tertiary: AppColors.primaryLight,
          onTertiary: AppColors.onPrimary,
          error: AppColors.error,
          onError: AppColors.onError,
          background: AppColors.background,
          onBackground: AppColors.onBackground,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          surfaceVariant: AppColors.surfaceVariant,
          onSurfaceVariant: AppColors.textSecondary,
          outline: AppColors.divider,
          shadow: AppColors.shadow,
          inverseSurface: AppColors.textPrimary,
          onInverseSurface: AppColors.background,
          inversePrimary: AppColors.primaryDark,
        ),

        // Typography
        textTheme: TextTheme(
          displayLarge: AppTypography.displayLarge,
          displayMedium: AppTypography.displayMedium,
          displaySmall: AppTypography.displaySmall,
          headlineLarge: AppTypography.headlineLarge,
          headlineMedium: AppTypography.headlineMedium,
          headlineSmall: AppTypography.headlineSmall,
          titleLarge: AppTypography.titleLarge,
          titleMedium: AppTypography.titleMedium,
          titleSmall: AppTypography.titleSmall,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),

        // Component Themes
        appBarTheme: ComponentThemes.appBarTheme,
        bottomNavigationBarTheme: ComponentThemes.bottomNavigationBarTheme,
        cardTheme: ComponentThemes.cardTheme,
        inputDecorationTheme: ComponentThemes.inputDecorationTheme,
        elevatedButtonTheme: ComponentThemes.elevatedButtonTheme,
        textButtonTheme: ComponentThemes.textButtonTheme,
        outlinedButtonTheme: ComponentThemes.outlinedButtonTheme,
        iconTheme: ComponentThemes.iconTheme,
        dividerTheme: ComponentThemes.dividerTheme,
        chipTheme: ComponentThemes.chipTheme,
        tabBarTheme: ComponentThemes.tabBarTheme,
        snackBarTheme: ComponentThemes.snackBarTheme,
        floatingActionButtonTheme: ComponentThemes.floatingActionButtonTheme,

        // Visual Density
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  // Light theme for future implementation
  static ThemeData get lightTheme => darkTheme.copyWith(
        brightness: Brightness.light,
        // TODO: Implement light theme colors when needed
      );

  // Theme extensions for custom properties
  static ThemeData withExtensions(ThemeData theme) {
    return theme.copyWith(
      extensions: [
        // Custom theme extensions can be added here
        // Example: CustomColorExtension, CustomSpacingExtension
      ],
    );
  }
}