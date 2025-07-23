import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

/// Individual component theme configurations
class ComponentThemes {
  ComponentThemes._();

  static AppBarThemeData get appBarTheme => AppBarThemeData(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTypography.appBarTitle,
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppDimensions.iconSizeMd,
    ),
    toolbarHeight: AppDimensions.appBarHeight,
  );

  static BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceContainer,
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
      );

  static CardThemeData get cardTheme => CardThemeData(
    color: AppColors.surface,
    elevation: AppDimensions.cardElevation,
    shadowColor: AppColors.shadow,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusLg)),
    ),
    margin: const EdgeInsets.all(AppDimensions.spacingXs),
  );

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    hintStyle: AppTypography.bodyMedium,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppDimensions.spacingMd,
      vertical: AppDimensions.spacingSm,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusLg)),
      borderSide: BorderSide.none,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusLg)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusLg)),
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusLg)),
      borderSide: BorderSide(
        color: AppColors.error,
        width: 1,
      ),
    ),
  );

  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: AppDimensions.cardElevation,
          shadowColor: AppColors.shadow,
          textStyle: AppTypography.buttonMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXl,
            vertical: AppDimensions.spacingSm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusFull)),
          ),
          minimumSize: const Size(0, AppDimensions.buttonHeight),
        ),
      );

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: AppTypography.buttonMedium,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingXs,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusMd)),
      ),
    ),
  );

  static OutlinedButtonThemeData get outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          textStyle: AppTypography.buttonMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXl,
            vertical: AppDimensions.spacingSm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusFull)),
          ),
          minimumSize: const Size(0, AppDimensions.buttonHeight),
        ),
      );

  static const IconThemeData iconTheme = IconThemeData(
    color: AppColors.textPrimary,
    size: AppDimensions.iconSizeMd,
  );

  static const DividerThemeData dividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: 1,
  );

  static ChipThemeData get chipTheme => ChipThemeData(
    backgroundColor: AppColors.surface,
    selectedColor: AppColors.primary,
    disabledColor: AppColors.disabled,
    deleteIconColor: AppColors.textSecondary,
    labelStyle: AppTypography.categoryChip,
    padding: const EdgeInsets.symmetric(
      horizontal: AppDimensions.spacingSm,
      vertical: AppDimensions.spacing2xs,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusFull)),
    ),
  );

  static TabBarThemeData get tabBarTheme => TabBarThemeData(
    labelColor: AppColors.primary,
    unselectedLabelColor: AppColors.textSecondary,
    labelStyle: AppTypography.labelLarge,
    unselectedLabelStyle: AppTypography.labelLarge,
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
      insets: EdgeInsets.zero,
    ),
    indicatorSize: TabBarIndicatorSize.label,
  );

  static SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    backgroundColor: AppColors.surface,
    contentTextStyle: AppTypography.bodyMedium.copyWith(
      color: AppColors.textPrimary,
    ),
    actionTextColor: AppColors.primary,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusMd)),
    ),
    elevation: AppDimensions.cardElevation,
  );

  static const FloatingActionButtonThemeData floatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: AppDimensions.cardElevation,
        focusElevation: AppDimensions.cardElevationHover,
        hoverElevation: AppDimensions.cardElevationHover,
      );
}