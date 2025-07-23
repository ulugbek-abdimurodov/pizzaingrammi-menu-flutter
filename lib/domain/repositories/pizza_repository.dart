import '../models/pizza.dart';
import '../models/filter_state.dart';
import '../../core/enums/app_enums.dart';

abstract class PizzaRepository {
  // Core CRUD operations
  Future<List<Pizza>> getAllPizzas();
  Future<Pizza?> getPizzaById(int id);
  Future<List<Pizza>> getPizzasByIds(List<int> ids);
  
  // Filtering and Search
  Future<FilterResult> filterPizzas(FilterState filters);
  Future<List<Pizza>> searchPizzas(String query);
  Future<List<Pizza>> getPizzasByCategory(PizzaCategory category);
  Future<List<Pizza>> getPizzasByTag(PizzaTag tag);
  
  // Sorting
  Future<List<Pizza>> sortPizzas(List<Pizza> pizzas, SortOption sortOption);
  
  // Favorites (for future implementation)
  Future<List<Pizza>> getFavoritePizzas();
  Future<void> addToFavorites(int pizzaId);
  Future<void> removeFromFavorites(int pizzaId);
  
  // Analytics (for future implementation)
  Future<List<Pizza>> getPopularPizzas({int limit = 10});
  Future<List<Pizza>> getRecentlyAddedPizzas({int limit = 5});
  Future<List<Pizza>> getRecommendedPizzas({int limit = 5});
  
  // Caching
  void clearCache();
  Future<void> refreshData();
}

// Exception classes for better error handling
class PizzaRepositoryException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const PizzaRepositoryException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'PizzaRepositoryException: $message';
}

class PizzaNotFoundException extends PizzaRepositoryException {
  const PizzaNotFoundException(int id) 
      : super('Pizza with id $id not found', code: 'PIZZA_NOT_FOUND');
}

class NetworkException extends PizzaRepositoryException {
  const NetworkException(String message) 
      : super(message, code: 'NETWORK_ERROR');
}

class CacheException extends PizzaRepositoryException {
  const CacheException(String message) 
      : super(message, code: 'CACHE_ERROR');
}