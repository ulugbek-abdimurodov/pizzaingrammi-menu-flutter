// presentation/widgets/empty_state_widget.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/constants/app_constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onRetry;
  final String? emoji;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onRetry,
    this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji ?? '🍕',
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spacingXl),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
