import '../../domain/models/pizza.dart';
import '../../domain/models/filter_state.dart';
import '../../domain/repositories/pizza_repository.dart';
import '../../core/enums/app_enums.dart';
import '../../core/constants/app_constants.dart';
import '../datasources/pizza_data_source.dart';

class PizzaService implements PizzaRepository {
  final PizzaDataSource _dataSource;
  
  // Simple in-memory cache
  List<Pizza>? _cachedPizzas;
  DateTime? _lastCacheUpdate;
  static const Duration _cacheValidDuration = Duration(minutes: 15);

  PizzaService(this._dataSource);

  @override
  Future<List<Pizza>> getAllPizzas() async {
    try {
      // Check cache first
      if (_isValidCache()) {
        return _cachedPizzas!;
      }

      // Fetch from data source
      final pizzas = await _dataSource.fetchAllPizzas();
      
      // Update cache
      _updateCache(pizzas);
      
      return pizzas;
    } catch (e) {
      throw PizzaRepositoryException(
        'Failed to fetch pizzas: ${e.toString()}',
        originalError: e,
      );
    }
  }

  @override
  Future<Pizza?> getPizzaById(int id) async {
    try {
      final pizzas = await getAllPizzas();
      return pizzas.cast<Pizza?>().firstWhere(
        (pizza) => pizza?.id == id,
        orElse: () => null,
      );
    } catch (e) {
      throw PizzaRepositoryException(
        'Failed to fetch pizza with id $id: ${e.toString()}',
        originalError: e,
      );
    }
  }

  @override
  Future<List<Pizza>> getPizzasByIds(List<int> ids) async {
    try {
      final allPizzas = await getAllPizzas();
      return allPizzas.where((pizza) => ids.contains(pizza.id)).toList();
    } catch (e) {
      throw PizzaRepositoryException(
        'Failed to fetch pizzas by ids: ${e.toString()}',
        originalError: e,
      );
    }
  }

  @override
  Future<FilterResult> filterPizzas(FilterState filters) async {
    try {
      // Simulate loading delay for better UX
      await Future.delayed(AppConstants.searchDebounceDelay);

      final allPizzas = await getAllPizzas();
      List<Pizza> filteredPizzas = List.from(allPizzas);

      // Apply availability filter
      if (filters.showOnlyAvailable) {
        filteredPizzas = filteredPizzas.where((pizza) => pizza.isAvailable).toList();
      }

      // Apply search filter
      if (filters.hasSearchQuery) {
        filteredPizzas = filteredPizzas
            .where((pizza) => pizza.matchesSearch(filters.searchQuery))
            .toList();
      }

      // Apply category filter
      if (filters.hasCategoryFilter) {
        filteredPizzas = filteredPizzas
            .where((pizza) => pizza.hasCategory(filters.selectedCategory))
            .toList();
      }

      // Apply tag filters
      if (filters.hasTagFilters) {
        filteredPizzas = filteredPizzas
            .where((pizza) => pizza.hasAnyTag(filters.selectedTags))
            .toList();
      }

      // Apply price filter
      if (filters.hasPriceFilter) {
        filteredPizzas = filteredPizzas.where((pizza) {
          final price = pizza.price;
          final minOk = filters.minPrice == null || price >= filters.minPrice!;
          final maxOk = filters.maxPrice == null || price <= filters.maxPrice!;
          return minOk && maxOk;
        }).toList();
      }

      // Apply sorting
      filteredPizzas = await sortPizzas(filteredPizzas, filters.sortOption);

      // Return result
      if (filteredPizzas.isEmpty) {
        return FilterResult.empty(filters);
      }

      return FilterResult(
        pizzas: filteredPizzas,
        totalCount: filteredPizzas.length,
        appliedFilters: filters,
        state: LoadingState.loaded,
      );
    } catch (e) {
      return FilterResult.error(
        filters,
        'Failed to filter pizzas: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<Pizza>> searchPizzas(String query) async {
    final filters = FilterState(searchQuery: query);
    final result = await filterPizzas(filters);
    return result.pizzas;
  }

  @override
  Future<List<Pizza>> getPizzasByCategory(PizzaCategory category) async {
    final filters = FilterState(selectedCategory: category);
    final result = await filterPizzas(filters);
    return result.pizzas;
  }

  @override
  Future<List<Pizza>> getPizzasByTag(PizzaTag tag) async {
    final filters = FilterState(selectedTags: [tag]);
    final result = await filterPizzas(filters);
    return result.pizzas;
  }

  @override
  Future<List<Pizza>> sortPizzas(List<Pizza> pizzas, SortOption sortOption) async {
    final sortedPizzas = List<Pizza>.from(pizzas);

    switch (sortOption) {
      case SortOption.alphabetical:
        sortedPizzas.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.priceAscending:
        sortedPizzas.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDescending:
        sortedPizzas.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.popularity:
        sortedPizzas.sort((a, b) {
          // Popular items first, then by name
          if (a.isPopular && !b.isPopular) return -1;
          if (!a.isPopular && b.isPopular) return 1;
          return a.name.compareTo(b.name);
        });
        break;
      case SortOption.newest:
        sortedPizzas.sort((a, b) {
          // New items first, then by creation date, then by name
          if (a.isNew && !b.isNew) return -1;
          if (!a.isNew && b.isNew) return 1;
          
          if (a.createdAt != null && b.createdAt != null) {
            return b.createdAt!.compareTo(a.createdAt!);
          }
          return a.name.compareTo(b.name);
        });
        break;
    }

    return sortedPizzas;
  }

  @override
  Future<List<Pizza>> getFavoritePizzas() async {
    // TODO: Implement with local storage/database
    throw UnimplementedError('Favorites not implemented yet');
  }

  @override
  Future<void> addToFavorites(int pizzaId) async {
    // TODO: Implement with local storage/database
    throw UnimplementedError('Favorites not implemented yet');
  }

  @override
  Future<void> removeFromFavorites(int pizzaId) async {
    // TODO: Implement with local storage/database
    throw UnimplementedError('Favorites not implemented yet');
  }

  @override
  Future<List<Pizza>> getPopularPizzas({int limit = 10}) async {
    try {
      final allPizzas = await getAllPizzas();
      final popularPizzas = allPizzas
          .where((pizza) => pizza.isPopular)
          .take(limit)
          .toList();
      
      return await sortPizzas(popularPizzas, SortOption.popularity);
    } catch (e) {
      throw PizzaRepositoryException(
        'Failed to fetch popular pizzas: ${e.toString()}',
        originalError: e,
      );
    }
  }

  @override
  Future<List<Pizza>> getRecentlyAddedPizzas({int limit = 5}) async {
    try {
      final allPizzas = await getAllPizzas();
      final recentPizzas = allPizzas
          .where((pizza) => pizza.isNew)
          .take(limit)
          .toList();
      
      return await sortPizzas(recentPizzas, SortOption.newest);
    } catch (e) {
      throw PizzaRepositoryException(
        'Failed to fetch recently added pizzas: ${e.toString()}',
        originalError: e,
      );
    }
  }

  @override
  Future<List<Pizza>> getRecommendedPizzas({int limit = 5}) async {
    try {
      final allPizzas = await getAllPizzas();
      
      // Simple recommendation logic: popular + new items
      final recommended = <Pizza>[];
      
      // Add popular pizzas
      recommended.addAll(
        allPizzas.where((pizza) => pizza.isPopular).take(limit ~/ 2),
      );
      
      // Add new pizzas if we need more
      if (recommended.length < limit) {
        final newPizzas = allPizzas
            .where((pizza) => pizza.isNew && !recommended.contains(pizza))
            .take(limit - recommended.length);
        recommended.addAll(newPizzas);
      }
      
      // Fill remaining with bestsellers
      if (recommended.length < limit) {
        final bestsellers = allPizzas
            .where((pizza) => pizza.isBestseller && !recommended.contains(pizza))
            .take(limit - recommended.length);
        recommended.addAll(bestsellers);
      }
      
      return recommended;
    } catch (e) {
      throw PizzaRepositoryException(
        'Failed to fetch recommended pizzas: ${e.toString()}',
        originalError: e,
      );
    }
  }

  @override
  void clearCache() {
    _cachedPizzas = null;
    _lastCacheUpdate = null;
  }

  @override
  Future<void> refreshData() async {
    clearCache();
    await getAllPizzas(); // This will fetch fresh data and update cache
  }

  // Private helper methods
  bool _isValidCache() {
    if (_cachedPizzas == null || _lastCacheUpdate == null) {
      return false;
    }
    
    final now = DateTime.now();
    final cacheAge = now.difference(_lastCacheUpdate!);
    
    return cacheAge < _cacheValidDuration;
  }

  void _updateCache(List<Pizza> pizzas) {
    _cachedPizzas = pizzas;
    _lastCacheUpdate = DateTime.now();
  }
}