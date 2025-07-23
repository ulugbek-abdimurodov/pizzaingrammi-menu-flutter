/// Design system spacing and sizing constants
class AppDimensions {
  AppDimensions._();

  // Base spacing unit (4dp grid system)
  static const double _baseUnit = 4.0;

  // Spacing Scale
  static const double spacing2xs = _baseUnit; // 4
  static const double spacingXs = _baseUnit * 2; // 8
  static const double spacingSm = _baseUnit * 3; // 12
  static const double spacingMd = _baseUnit * 4; // 16
  static const double spacingLg = _baseUnit * 5; // 20
  static const double spacingXl = _baseUnit * 6; // 24
  static const double spacing2xl = _baseUnit * 8; // 32
  static const double spacing3xl = _baseUnit * 12; // 48
  static const double spacing4xl = _baseUnit * 16; // 64

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2xl = 20.0;
  static const double radius3xl = 24.0;
  static const double radiusFull = 9999.0;

  // Component Specific Dimensions
  static const double buttonHeight = 48.0;
  static const double buttonHeightSm = 40.0;
  static const double buttonHeightLg = 56.0;

  static const double inputHeight = 48.0;
  static const double inputHeightSm = 40.0;
  static const double inputHeightLg = 56.0;

  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 80.0;
  static const double tabBarHeight = 48.0;

  static const double cardElevation = 2.0;
  static const double cardElevationHover = 8.0;

  static const double iconSizeXs = 16.0;
  static const double iconSizeSm = 20.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;
  static const double iconSizeXl = 48.0;

  // Layout Dimensions
  static const double maxContentWidth = 1200.0;
  static const double sidebarWidth = 280.0;
  static const double drawerWidth = 320.0;

  // Grid System
  static const double gridGutter = spacingMd;
  static const int gridColumns = 12;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 250);
  static const Duration animationSlow = Duration(milliseconds: 400);

  // Breakpoints (Material Design)
  static const double breakpointXs = 0;
  static const double breakpointSm = 600;
  static const double breakpointMd = 1024;
  static const double breakpointLg = 1440;
  static const double breakpointXl = 1920;

  // Pizza Card Specific
  static const double pizzaCardHeight = 120.0;
  static const double pizzaImageSize = 80.0;
  static const double categoryTabHeight = 80.0;
  static const double filterChipHeight = 32.0;

  // Search Bar
  static const double searchBarHeight = inputHeight;
  static const double searchBarRadius = radiusLg;

  // Feature Card
  static const double featuredCardHeight = 200.0;
  static const double featuredCardWidth = 280.0;
}