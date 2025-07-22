import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../models/category.dart';
import '../models/featured_item.dart';
import '../services/data_service.dart';
import '../widgets/pizza_card.dart';
import '../widgets/featured_card.dart';
import '../widgets/category_tab.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/filter_chip_custom.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  String _activeCategory = 'pizzas';
  String _searchQuery = '';
  bool _isGlutenFreeFilter = false;
  bool _isVeganFilter = false;
  int _currentBottomNavIndex = 0;
  
  List<Pizza> _allPizzas = [];
  List<Category> _categories = [];
  List<FeaturedItem> _featuredItems = [];
  
  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _loadData() {
    setState(() {
      _allPizzas = DataService.getPizzas();
      _categories = DataService.getCategories();
      _featuredItems = DataService.getFeaturedItems();
    });
  }
  
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }
  
  List<Pizza> get _filteredPizzas {
    List<Pizza> pizzas = _allPizzas;
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      pizzas = DataService.searchPizzas(pizzas, _searchQuery);
    }
    
    // Apply diet filters
    pizzas = DataService.filterPizzasByDiet(
      pizzas,
      isGlutenFree: _isGlutenFreeFilter ? true : null,
      isVegan: _isVeganFilter ? true : null,
    );
    
    return pizzas;
  }
  
  void _onCategoryChanged(String categoryId) {
    setState(() {
      _activeCategory = categoryId;
    });
  }
  
  void _onFilterChanged(String filter) {
    setState(() {
      if (filter == 'gluten-free') {
        _isGlutenFreeFilter = !_isGlutenFreeFilter;
      } else if (filter == 'vegan') {
        _isVeganFilter = !_isVeganFilter;
      }
    });
  }
  
  void _onPizzaTapped(Pizza pizza) {
    // TODO: Navigate to pizza details screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pizza.title} tapped!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
  
  void _onAddToCart(Pizza pizza) {
    // TODO: Add pizza to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pizza.title} added to cart!'),
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  void _onFeaturedItemTapped(FeaturedItem item) {
    // TODO: Handle featured item tap
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} tapped!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Search Bar
            _buildSearchSection(),
            
            // Featured Section (hide during search)
            if (_searchQuery.isEmpty) _buildFeaturedSection(),
            
            // Menu Section
            _buildMenuSection(),
            
            // Categories
            _buildCategoriesSection(),
            
            // Filters (only show for pizzas and when not searching)
            if (_activeCategory == 'pizzas' && _searchQuery.isEmpty)
              _buildFiltersSection(),
            
            // Content
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Pizzaingrammi',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.015,
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // TODO: Navigate to cart
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              // Cart badge (optional)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: CustomSearchBar(
        controller: _searchController,
        onChanged: (value) => _onSearchChanged(),
        onClear: () => _onSearchChanged(),
      ),
    );
  }
  
  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Featured',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _featuredItems.length,
            itemBuilder: (context, index) {
              return FeaturedCard(
                item: _featuredItems[index],
                onTap: () => _onFeaturedItemTapped(_featuredItems[index]),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Menu',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
  
  Widget _buildCategoriesSection() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return CategoryTab(
            category: category,
            isActive: _activeCategory == category.id,
            onTap: () => _onCategoryChanged(category.id),
          );
        },
      ),
    );
  }
  
  Widget _buildFiltersSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          FilterChipCustom(
            label: 'Gluten-free',
            isSelected: _isGlutenFreeFilter,
            onTap: () => _onFilterChanged('gluten-free'),
            icon: Icons.no_meals,
          ),
          const SizedBox(width: 12),
          FilterChipCustom(
            label: 'Vegan',
            isSelected: _isVeganFilter,
            onTap: () => _onFilterChanged('vegan'),
            icon: Icons.eco,
          ),
        ],
      ),
    );
  }
  
  Widget _buildContent() {
    if (_activeCategory != 'pizzas') {
      return _buildComingSoon();
    }
    
    final filteredPizzas = _filteredPizzas;
    
    if (filteredPizzas.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredPizzas.length,
      itemBuilder: (context, index) {
        return PizzaCard(
          pizza: filteredPizzas[index],
          onTap: () => _onPizzaTapped(filteredPizzas[index]),
          onAddToCart: () => _onAddToCart(filteredPizzas[index]),
        );
      },
    );
  }
  
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🍕', style: TextStyle(fontSize: 48)),
          SizedBox(height: 16),
          Text(
            'No pizzas found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildComingSoon() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🔄', style: TextStyle(fontSize: 48)),
          SizedBox(height: 16),
          Text(
            'Coming Soon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'This menu will be available soon!',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bottomNavBackground,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
          // TODO: Handle navigation
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.bottomNavBackground,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}