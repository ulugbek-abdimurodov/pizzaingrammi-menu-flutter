import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/pizza.dart';
import '../../domain/models/filter_state.dart';
import '../../domain/repositories/pizza_repository.dart';
import '../../core/enums/app_enums.dart';

// Events
abstract class PizzaEvent extends Equatable {
  const PizzaEvent();

  @override
  List<Object?> get props => [];
}

class LoadPizzas extends PizzaEvent {
  const LoadPizzas();
}

class RefreshPizzas extends PizzaEvent {
  const RefreshPizzas();
}

class SearchPizzas extends PizzaEvent {
  final String query;
  
  const SearchPizzas(this.query);
  
  @override
  List<Object?> get props => [query];
}

class FilterByCategory extends PizzaEvent {
  final PizzaCategory category;
  
  const FilterByCategory(this.category);
  
  @override
  List<Object?> get props => [category];
}

class ToggleTagFilter extends PizzaEvent {
  final PizzaTag tag;
  
  const ToggleTagFilter(this.tag);
  
  @override
  List<Object?> get props => [tag];
}

class SortPizzas extends PizzaEvent {
  final SortOption sortOption;
  
  const SortPizzas(this.sortOption);
  
  @override
  List<Object?> get props => [sortOption];
}

class ResetFilters extends PizzaEvent {
  const ResetFilters();
}

class UpdateFilters extends PizzaEvent {
  final FilterState filters;
  
  const UpdateFilters(this.filters);
  
  @override
  List<Object?> get props => [filters];
}

// States
abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object?> get props => [];
}

class PizzaInitial extends PizzaState {
  const PizzaInitial();
}

class PizzaLoading extends PizzaState {
  const PizzaLoading();
}

class PizzaLoaded extends PizzaState {
  final List<Pizza> pizzas;
  final FilterState currentFilters;
  final int totalCount;
  final bool isFiltering;

  const PizzaLoaded({
    required this.pizzas,
    required this.currentFilters,
    required this.totalCount,
    this.isFiltering = false,
  });

  PizzaLoaded copyWith({
    List<Pizza>? pizzas,
    FilterState? currentFilters,
    int? totalCount,
    bool? isFiltering,
  }) {
    return PizzaLoaded(
      pizzas: pizzas ?? this.pizzas,
      currentFilters: currentFilters ?? this.currentFilters,
      totalCount: totalCount ?? this.totalCount,
      isFiltering: isFiltering ?? this.isFiltering,
    );
  }

  bool get hasResults => pizzas.isNotEmpty;
  bool get isEmpty => pizzas.isEmpty && !isFiltering;
  bool get hasActiveFilters => currentFilters.hasActiveFilters;

  @override
  List<Object?> get props => [pizzas, currentFilters, totalCount, isFiltering];
}

class PizzaError extends PizzaState {
  final String message;
  final FilterState? lastFilters;

  const PizzaError(this.message, {this.lastFilters});

  @override
  List<Object?> get props => [message, lastFilters];
}

// Cubit
class PizzaCubit extends Cubit<PizzaState> {
  final PizzaRepository _repository;
  
  Timer? _debounceTimer;
  FilterState _currentFilters = FilterState.initial();
  
  static const Duration _debounceDelay = Duration(milliseconds: 300);

  PizzaCubit(this._repository) : super(const PizzaInitial());

  FilterState get currentFilters => _currentFilters;

  Future<void> loadPizzas() async {
    try {
      emit(const PizzaLoading());
      
      final result = await _repository.filterPizzas(_currentFilters);
      
      if (result.hasError) {
        emit(PizzaError(result.errorMessage!, lastFilters: _currentFilters));
        return;
      }

      emit(PizzaLoaded(
        pizzas: result.pizzas,
        currentFilters: _currentFilters,
        totalCount: result.totalCount,
      ));
    } catch (e) {
      emit(PizzaError(
        'Failed to load pizzas: ${e.toString()}',
        lastFilters: _currentFilters,
      ));
    }
  }

  Future<void> refreshPizzas() async {
    try {
      // Clear cache and reload
      _repository.clearCache();
      await _repository.refreshData();
      await loadPizzas();
    } catch (e) {
      emit(PizzaError(
        'Failed to refresh pizzas: ${e.toString()}',
        lastFilters: _currentFilters,
      ));
    }
  }

  void searchPizzas(String query) {
    _debounceTimer?.cancel();
    
    if (query == _currentFilters.searchQuery) return;

    // Show immediate loading state for search
    final currentState = state;
    if (currentState is PizzaLoaded) {
      emit(currentState.copyWith(isFiltering: true));
    }

    _debounceTimer = Timer(_debounceDelay, () {
      _updateFilters(_currentFilters.copyWith(searchQuery: query));
    });
  }

  void filterByCategory(PizzaCategory category) {
    _updateFilters(_currentFilters.copyWith(selectedCategory: category));
  }

  void toggleTagFilter(PizzaTag tag) {
    _updateFilters(_currentFilters.toggleTag(tag));
  }

  void sortPizzas(SortOption sortOption) {
    _updateFilters(_currentFilters.copyWith(sortOption: sortOption));
  }

  void resetFilters() {
    _updateFilters(FilterState.initial());
  }

  void updateFilters(FilterState filters) {
    _updateFilters(filters);
  }

  void setPriceRange({double? minPrice, double? maxPrice}) {
    _updateFilters(_currentFilters.copyWith(
      minPrice: minPrice,
      maxPrice: maxPrice,
    ));
  }

  void toggleOnlyAvailable() {
    _updateFilters(_currentFilters.copyWith(
      showOnlyAvailable: !_currentFilters.showOnlyAvailable,
    ));
  }

  Future<void> _updateFilters(FilterState newFilters) async {
    if (newFilters == _currentFilters) return;

    _currentFilters = newFilters;

    try {
      // Show filtering state
      final currentState = state;
      if (currentState is PizzaLoaded) {
        emit(currentState.copyWith(isFiltering: true));
      }

      final result = await _repository.filterPizzas(_currentFilters);

      if (result.hasError) {
        emit(PizzaError(result.errorMessage!, lastFilters: _currentFilters));
        return;
      }

      emit(PizzaLoaded(
        pizzas: result.pizzas,
        currentFilters: _currentFilters,
        totalCount: result.totalCount,
        isFiltering: false,
      ));
    } catch (e) {
      emit(PizzaError(
        'Failed to filter pizzas: ${e.toString()}',
        lastFilters: _currentFilters,
      ));
    }
  }

  // Convenience methods for quick access
  Future<void> loadPopularPizzas() async {
    try {
      emit(const PizzaLoading());
      
      final popularPizzas = await _repository.getPopularPizzas();
      
      emit(PizzaLoaded(
        pizzas: popularPizzas,
        currentFilters: FilterState(
          selectedTags: [PizzaTag.popular],
        ),
        totalCount: popularPizzas.length,
      ));
    } catch (e) {
      emit(PizzaError('Failed to load popular pizzas: ${e.toString()}'));
    }
  }

  Future<void> loadNewPizzas() async {
    try {
      emit(const PizzaLoading());
      
      final newPizzas = await _repository.getRecentlyAddedPizzas();
      
      emit(PizzaLoaded(
        pizzas: newPizzas,
        currentFilters: FilterState(
          selectedTags: [PizzaTag.newItem],
        ),
        totalCount: newPizzas.length,
      ));
    } catch (e) {
      emit(PizzaError('Failed to load new pizzas: ${e.toString()}'));
    }
  }

  Future<void> loadRecommendedPizzas() async {
    try {
      emit(const PizzaLoading());
      
      final recommendedPizzas = await _repository.getRecommendedPizzas();
      
      emit(PizzaLoaded(
        pizzas: recommendedPizzas,
        currentFilters: FilterState.initial(),
        totalCount: recommendedPizzas.length,
      ));
    } catch (e) {
      emit(PizzaError('Failed to load recommended pizzas: ${e.toString()}'));
    }
  }

  // Cleanup
  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  // Helper methods for UI
  bool isTagSelected(PizzaTag tag) {
    return _currentFilters.selectedTags.contains(tag);
  }

  bool isCategorySelected(PizzaCategory category) {
    return _currentFilters.selectedCategory == category;
  }

  bool isSortSelected(SortOption sort) {
    return _currentFilters.sortOption == sort;
  }

  List<PizzaCategory> getAvailableCategories() {
    return PizzaCategory.values;
  }

  List<PizzaTag> getAvailableTags() {
    return PizzaTag.values;
  }

  List<SortOption> getAvailableSortOptions() {
    return SortOption.values;
  }

  // Analytics helpers
  String getFilterSummary() {
    final parts = <String>[];
    
    if (_currentFilters.hasSearchQuery) {
      parts.add('Search: "${_currentFilters.searchQuery}"');
    }
    
    if (_currentFilters.hasCategoryFilter) {
      parts.add('Category: ${_currentFilters.selectedCategory.displayName}');
    }
    
    if (_currentFilters.hasTagFilters) {
      final tagNames = _currentFilters.selectedTags
          .map((tag) => tag.displayName)
          .join(', ');
      parts.add('Tags: $tagNames');
    }
    
    if (_currentFilters.hasPriceFilter) {
      final min = _currentFilters.minPrice?.toStringAsFixed(2) ?? '0';
      final max = _currentFilters.maxPrice?.toStringAsFixed(2) ?? '∞';
      parts.add('Price: €$min - €$max');
    }
    
    return parts.isEmpty ? 'No filters applied' : parts.join(' | ');
  }
}