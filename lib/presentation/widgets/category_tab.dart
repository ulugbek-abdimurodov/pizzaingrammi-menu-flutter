import 'package:flutter/material.dart';
import '../../core/enums/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class CustomCategoryTab extends StatelessWidget {
  final PizzaCategory category;
  final bool isActive;
  final VoidCallback onTap;

  const CustomCategoryTab({
    super.key,
    required this.category,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDimensions.animationFast,
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: AppDimensions.spacingMd),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingXs,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          border: isActive
              ? null
              : Border.all(
                  color: AppColors.divider,
                  width: 1,
                ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(width: AppDimensions.spacingXs),
            _buildLabel(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    switch (category) {
      case PizzaCategory.all:
        iconData = Icons.restaurant_menu;
        break;
      case PizzaCategory.classic:
        iconData = Icons.local_pizza;
        break;
      case PizzaCategory.specialty:
        iconData = Icons.stars;
        break;
      case PizzaCategory.vegan:
        iconData = Icons.eco;
        break;
      case PizzaCategory.glutenFree:
        iconData = Icons.no_meals;
        break;
      case PizzaCategory.spicy:
        iconData = Icons.local_fire_department;
        break;
    }

    return Icon(
      iconData,
      size: AppDimensions.iconSizeSm,
      color: isActive ? AppColors.onPrimary : AppColors.textSecondary,
    );
  }

  Widget _buildLabel() {
    return Text(
      category.displayName,
      style: AppTypography.categoryChip.copyWith(
        color: isActive ? AppColors.onPrimary : AppColors.textPrimary,
        fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
      ),
    );
  }
}