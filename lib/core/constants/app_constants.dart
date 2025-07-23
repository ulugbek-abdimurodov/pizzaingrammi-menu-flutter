class AppConstants {
  // App Info
  static const String appName = 'Pizzaingrammi';
  static const String appTagline = 'Bringing authentic Italian pizza to your doorstep!';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const Duration searchDebounceDelay = Duration(milliseconds: 300);
  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Duration loadingSimulationDelay = Duration(milliseconds: 800);

  // UI Constants
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 20.0;
  
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  static const double cardElevation = 2.0;
  static const double cardElevationHover = 8.0;

  // Image Configuration
  static const double imageAspectRatio = 1.0;
  static const String imagePlaceholder = 'assets/images/pizza_placeholder.png';
  
  // Cart Configuration
  static const int maxCartItems = 99;
  static const double minOrderAmount = 10.0;
  
  // Filter Options
  static const List<String> categories = [
    'All',
    'Classic',
    'Specialty', 
    'Vegan',
    'Gluten-free',
    'Spicy'
  ];
  
  // Pizza Tags
  static const List<String> availableTags = [
    'popular',
    'new',
    'bestseller',
    'chef-special',
    'limited-time'
  ];
}

class AppStrings {
  // Navigation
  static const String home = 'Home';
  static const String menu = 'Menu';
  static const String cart = 'Cart';
  static const String profile = 'Profile';
  
  // Search & Filters
  static const String searchHint = 'Search for food or items';
  static const String searchPlaceholder = 'Search pizzas...';
  static const String filterAll = 'All';
  static const String resetFilters = 'Reset Filters';
  static const String noResults = 'No pizzas found';
  static const String tryDifferentSearch = 'Try adjusting your search or filters';
  
  // Features
  static const String featured = 'Featured';
  static const String addToCart = 'Add to Cart';
  static const String viewDetails = 'View Details';
  static const String comingSoon = 'Coming Soon';
  static const String menuAvailableSoon = 'This menu will be available soon!';
  
  // Categories
  static const String classic = 'Classic';
  static const String specialty = 'Specialty';
  static const String vegan = 'Vegan';
  static const String glutenFree = 'Gluten-free';
  static const String spicy = 'Spicy';
  
  // Tags & Badges
  static const String popular = 'POPULAR';
  static const String newItem = 'NEW';
  static const String bestseller = 'BESTSELLER';
  
  // Actions
  static const String addedToCart = 'added to cart!';
  static const String learnMore = 'Learn More';
  static const String viewCart = 'View Cart';
  static const String checkout = 'Checkout';
  
  // Errors
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Check your connection.';
  static const String errorLoading = 'Failed to load data.';
}

class AppAssets {
  // Icons
  static const String iconPizza = 'assets/icons/pizza.svg';
  static const String iconSpicy = 'assets/icons/spicy.svg';
  static const String iconVegan = 'assets/icons/vegan.svg';
  static const String iconGlutenFree = 'assets/icons/gluten_free.svg';
  
  // Images
  static const String logoLight = 'assets/images/logo_light.png';
  static const String logoDark = 'assets/images/logo_dark.png';
  static const String pizzaPlaceholder = 'assets/images/pizza_placeholder.png';
  static const String emptyCart = 'assets/images/empty_cart.svg';
  static const String noResults = 'assets/images/no_results.svg';
  
  // Lottie Animations
  static const String loadingAnimation = 'assets/animations/loading.json';
  static const String successAnimation = 'assets/animations/success.json';
  static const String errorAnimation = 'assets/animations/error.json';
}