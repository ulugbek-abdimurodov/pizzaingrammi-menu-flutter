import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onClear,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
    widget.onChanged?.call(widget.controller.text);
  }

  void _clearSearch() {
    widget.controller.clear();
    widget.onClear?.call();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.searchBarHeight,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.searchBarRadius),
        border: _hasFocus
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          _buildSearchIcon(),
          _buildTextField(),
          if (widget.controller.text.isNotEmpty) _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildSearchIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
      ),
      child: Icon(
        Icons.search,
        color: _hasFocus ? AppColors.primary : AppColors.textSecondary,
        size: AppDimensions.iconSizeMd,
      ),
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _hasFocus = hasFocus;
          });
        },
        child: TextField(
          controller: widget.controller,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTypography.bodyMedium,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppDimensions.spacingSm,
            ),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return GestureDetector(
      onTap: _clearSearch,
      child: Container(
        margin: const EdgeInsets.only(right: AppDimensions.spacingSm),
        padding: const EdgeInsets.all(AppDimensions.spacing2xs),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          color: AppColors.textSecondary,
          size: AppDimensions.iconSizeXs,
        ),
      ),
    );
  }
}