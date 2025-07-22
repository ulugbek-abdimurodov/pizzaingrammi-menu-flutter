import 'package:flutter/material.dart';
import '../models/category.dart';
import '../theme/app_colors.dart';

class CategoryTab extends StatelessWidget {
  final Category category;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryTab({
    Key? key,
    required this.category,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(category.iconUrl),
                  fit: BoxFit.cover,
                ),
                border: isActive
                    ? Border.all(color: AppColors.accent, width: 2)
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            
            // Category name
            Text(
              category.name,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // Item count (optional)
            if (category.itemCount > 0) ...[
              const SizedBox(height: 2),
              Text(
                '${category.itemCount} items',
                style: TextStyle(
                  color: isActive 
                      ? AppColors.textSecondary 
                      : AppColors.textSecondary.withOpacity(0.7),
                  fontSize: 10,
                ),
              ),
            ],
            
            const SizedBox(height: 8),
            
            // Active indicator
            Container(
              height: 3,
              width: 60,
              decoration: BoxDecoration(
                color: isActive ? AppColors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}