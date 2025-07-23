enum PizzaCategory {
  all('All'),
  classic('Classic'),
  specialty('Specialty'),
  vegan('Vegan'),
  glutenFree('Gluten-free'),
  spicy('Spicy');

  const PizzaCategory(this.displayName);
  final String displayName;

  static PizzaCategory fromString(String value) {
    return PizzaCategory.values.firstWhere(
      (category) => category.name.toLowerCase() == value.toLowerCase(),
      orElse: () => PizzaCategory.all,
    );
  }
}

enum PizzaTag {
  popular('popular', 'POPULAR'),
  newItem('new', 'NEW'),
  bestseller('bestseller', 'BESTSELLER'),
  chefSpecial('chef-special', 'CHEF SPECIAL'),
  limitedTime('limited-time', 'LIMITED TIME');

  const PizzaTag(this.value, this.displayName);
  final String value;
  final String displayName;

  static PizzaTag? fromString(String value) {
    try {
      return PizzaTag.values.firstWhere(
        (tag) => tag.value.toLowerCase() == value.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}

enum LoadingState {
  initial,
  loading,
  loaded,
  error,
  empty;

  bool get isLoading => this == LoadingState.loading;
  bool get isLoaded => this == LoadingState.loaded;
  bool get hasError => this == LoadingState.error;
  bool get isEmpty => this == LoadingState.empty;
  bool get isInitial => this == LoadingState.initial;
}

enum CartActionType {
  add,
  remove,
  increase,
  decrease,
  clear;
}

enum FilterType {
  category,
  search,
  tag,
  price;
}

enum NavigationTab {
  home(0, 'Home'),
  menu(1, 'Menu'),
  cart(2, 'Cart'),
  profile(3, 'Profile');

  const NavigationTab(this.tabIndex, this.label);
  final int tabIndex;  // Changed from 'index' to 'tabIndex'
  final String label;
}

enum SortOption {
  alphabetical('Name A-Z'),
  priceAscending('Price: Low to High'),
  priceDescending('Price: High to Low'),
  popularity('Most Popular'),
  newest('Newest First');

  const SortOption(this.displayName);
  final String displayName;
}

enum AnimationType {
  fadeIn,
  slideUp,
  slideDown,
  slideLeft,
  slideRight,
  scale,
  bounce;
}

enum BreakPoint {
  mobile(maxWidth: 640),
  tablet(maxWidth: 768),
  desktop(maxWidth: double.infinity);

  const BreakPoint({required this.maxWidth});
  final double maxWidth;

  static BreakPoint fromWidth(double width) {
    if (width <= mobile.maxWidth) return mobile;
    if (width <= tablet.maxWidth) return tablet;
    return desktop;
  }

  bool get isMobile => this == BreakPoint.mobile;
  bool get isTablet => this == BreakPoint.tablet;
  bool get isDesktop => this == BreakPoint.desktop;
}