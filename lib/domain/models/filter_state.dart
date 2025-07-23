import 'package:equatable/equatable.dart';
import '../../core/enums/app_enums.dart';

class FilterState extends Equatable {
  final String searchQuery;
  final PizzaCategory selectedCategory;
  final List<PizzaTag> selectedTags;
  final SortOption sortOption;
  final double? minPrice;
  final double? maxPrice;
  final bool showOnlyAvailable;

  const FilterState({
    this.searchQuery = '',
    this.selectedCategory = PizzaCategory.all,
    this.selectedTags = const [],
    this.sortOption = SortOption.alphabetical,
    this.minPrice,
    this.maxPrice,
    this.showOnlyAvailable = true,
  });

  factory FilterState.initial() {
    return const FilterState();
  }

  FilterState copyWith({
    String? searchQuery,
    PizzaCategory? selectedCategory,
    List<PizzaTag>? selectedTags,
    SortOption? sortOption,
    double? minPrice,
    double? maxPrice,
    bool? showOnlyAvailable,
  }) {
    return FilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTags: selectedTags ?? this.selectedTags,
      sortOption: sortOption ?? this.sortOption,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      showOnlyAvailable: showOnlyAvailable ?? this.showOnlyAvailable,
    );
  }

  FilterState reset() {
    return FilterState.initial();
  }

  FilterState clearSearch() {
    return copyWith(searchQuery: '');
  }

  FilterState addTag(PizzaTag tag) {
    if (selectedTags.contains(tag)) return this;
    return copyWith(selectedTags: [...selectedTags, tag]);
  }

  FilterState removeTag(PizzaTag tag) {
    return copyWith(
      selectedTags: selectedTags.where((t) => t != tag).toList(),
    );
  }

  FilterState toggleTag(PizzaTag tag) {
    return selectedTags.contains(tag) ? removeTag(tag) : addTag(tag);
  }

  // State Checks
  bool get hasActiveFilters {
    return searchQuery.isNotEmpty ||
        selectedCategory != PizzaCategory.all ||
        selectedTags.isNotEmpty ||
        minPrice != null ||
        maxPrice != null ||
        !showOnlyAvailable;
  }

  bool get hasSearchQuery => searchQuery.isNotEmpty;
  bool get hasCategoryFilter => selectedCategory != PizzaCategory.all;
  bool get hasTagFilters => selectedTags.isNotEmpty;
  bool get hasPriceFilter => minPrice != null || maxPrice != null;

  int get activeFilterCount {
    int count = 0;
    if (hasSearchQuery) count++;
    if (hasCategoryFilter) count++;
    if (hasTagFilters) count += selectedTags.length;
    if (hasPriceFilter) count++;
    if (!showOnlyAvailable) count++;
    return count;
  }

  @override
  List<Object?> get props => [
    searchQuery,
    selectedCategory,
    selectedTags,
    sortOption,
    minPrice,
    maxPrice,
    showOnlyAvailable,
  ];

  @override
  String toString() {
    return 'FilterState('
           'searchQuery: $searchQuery, '
           'category: ${selectedCategory.name}, '
           'tags: ${selectedTags.map((t) => t.value).join(',')}, '
           'sort: ${sortOption.name}, '
           'priceRange: $minPrice-$maxPrice, '
           'onlyAvailable: $showOnlyAvailable'
           ')';
  }
}

class FilterResult extends Equatable {
  final List<Pizza> pizzas;
  final int totalCount;
  final FilterState appliedFilters;
  final LoadingState state;
  final String? errorMessage;

  const FilterResult({
    required this.pizzas,
    required this.totalCount,
    required this.appliedFilters,
    this.state = LoadingState.loaded,
    this.errorMessage,
  });

  factory FilterResult.loading(FilterState filters) {
    return FilterResult(
      pizzas: const [],
      totalCount: 0,
      appliedFilters: filters,
      state: LoadingState.loading,
    );
  }

  factory FilterResult.error(FilterState filters, String message) {
    return FilterResult(
      pizzas: const [],
      totalCount: 0,
      appliedFilters: filters,
      state: LoadingState.error,
      errorMessage: message,
    );
  }

  factory FilterResult.empty(FilterState filters) {
    return FilterResult(
      pizzas: const [],
      totalCount: 0,
      appliedFilters: filters,
      state: LoadingState.empty,
    );
  }

  FilterResult copyWith({
    List<Pizza>? pizzas,
    int? totalCount,
    FilterState? appliedFilters,
    LoadingState? state,
    String? errorMessage,
  }) {
    return FilterResult(
      pizzas: pizzas ?? this.pizzas,
      totalCount: totalCount ?? this.totalCount,
      appliedFilters: appliedFilters ?? this.appliedFilters,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isEmpty => pizzas.isEmpty && state.isLoaded;
  bool get hasResults => pizzas.isNotEmpty;
  bool get isLoading => state.isLoading;
  bool get hasError => state.hasError;

  @override
  List<Object?> get props => [
    pizzas,
    totalCount,
    appliedFilters,
    state,
    errorMessage,
  ];
}