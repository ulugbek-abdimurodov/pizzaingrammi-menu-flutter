import 'package:flutter/material.dart';
import '../../domain/models/pizza.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class CustomPizzaCard extends StatelessWidget {
  final Pizza pizza;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const CustomPizzaCard({
    super.key,
    required this.pizza,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildContent(context),
                ),
                const SizedBox(width: AppDimensions.spacingMd),
                _buildImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryAndTags(),
        const SizedBox(height: AppDimensions.spacingXs),
        _buildTitle(context),
        const SizedBox(height: AppDimensions.spacingXs),
        _buildDescription(context),
        const SizedBox(height: AppDimensions.spacingMd),
        _buildPriceAndAction(),
      ],
    );
  }

  Widget _buildCategoryAndTags() {
    return Row(
      children: [
        Text(
          pizza.primaryCategory,
          style: AppTypography.bodySmall,
        ),
        const SizedBox(width: AppDimensions.spacingXs),
        ...pizza.displayTags.map((tag) => _buildTagBadge(tag.displayName)),
      ],
    );
  }

  Widget _buildTagBadge(String text) {
    return Container(
      margin: const EdgeInsets.only(right: AppDimensions.spacing2xs),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing2xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXs),
      ),
      child: Text(
        text,
        style: AppTypography.badge,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      pizza.name,
      style: AppTypography.cardTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      pizza.description,
      style: AppTypography.bodyMedium,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceAndAction() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingSm,
            vertical: AppDimensions.spacing2xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          child: Text(
            pizza.formattedPrice,
            style: AppTypography.price.copyWith(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        if (onAddToCart != null) _buildAddButton(),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: onAddToCart,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.onPrimary,
          size: AppDimensions.iconSizeSm,
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: AppDimensions.pizzaImageSize,
      height: AppDimensions.pizzaImageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        child: Image.network(
          pizza.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.surfaceVariant,
              child: const Icon(
                Icons.local_pizza,
                color: AppColors.textSecondary,
                size: AppDimensions.iconSizeLg,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: AppColors.surfaceVariant,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}