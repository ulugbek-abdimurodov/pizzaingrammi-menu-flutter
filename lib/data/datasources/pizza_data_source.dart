import '../../domain/models/pizza.dart';
import '../../core/enums/app_enums.dart';
import '../../core/constants/app_constants.dart';

abstract class PizzaDataSource {
  Future<List<Pizza>> fetchAllPizzas();
  Future<Pizza?> fetchPizzaById(int id);
}

class LocalPizzaDataSource implements PizzaDataSource {
  @override
  Future<List<Pizza>> fetchAllPizzas() async {
    // Simulate network delay
    await Future.delayed(AppConstants.loadingSimulationDelay);
    
    return _menuItems;
  }

  @override
  Future<Pizza?> fetchPizzaById(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return _menuItems.firstWhere((pizza) => pizza.id == id);
    } catch (e) {
      return null;
    }
  }

  // Static data matching the HTML version structure
  static final List<Pizza> _menuItems = [
    Pizza(
      id: 1,
      name: "Margherita",
      description: "Classic pizza with tomato sauce, mozzarella, and fresh basil leaves.",
      price: 5.99,
      categories: [PizzaCategory.classic],
      tags: [PizzaTag.popular],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBYmfVx4LN8rA343zEfsayV1W3o7A1NM5c1gz1T-xIBUc9TzCUM3P9CyNHV6rFCSPcOMyUguuxOe91xD5Ec5gNxW9ytNSeUqdsnjoM1iYbhduVTqIB3zDlMJa4EPo3dRgiR7gVPZP7D2znVYVpWpQ_z2ERkuMyxjAgEjBVuyBLt-7sswBVrGuc3Ld6qGzoIHfgCULimb6xdDBXPEfXdKlcTUrtUj6F8moDKzfcnjXtzSNijuPP3r_Id20eEPTx4NPkZS_R5cUWJ5oYi",
      createdAt: DateTime(2024, 1, 15),
    ),
    Pizza(
      id: 2,
      name: "Pepperoni Classic",
      description: "Traditional pizza with tomato sauce, mozzarella, and premium pepperoni slices.",
      price: 14.99,
      categories: [PizzaCategory.classic],
      tags: [PizzaTag.newItem],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCVPZBgigWCIxTe6k3hP6dA2dvCag9o-hJMha1lI-c1XDnm-rhwv86mIzFI4iB6cJBdjKBVpYL8MSTosbvORwYXO7O9MNgAy5bQFY7STzEiCEChXp0LpI8oj9pLddbTMmEsWq92KWrRe2R-_0-WZsWSsdo-Fp2EZ62VRVZQKSQ-NmiQJB9qp7rDsady6e32xnkOcTwOLpRTQf4XpabGTYt74o5v_WRFSCI_oVXrGcmr-iriIaHAyi5SCIkv30AdNBx9KnrqpCLRD51u",
      createdAt: DateTime(2024, 12, 1),
    ),
    Pizza(
      id: 3,
      name: "Hawaiian Paradise",
      description: "Tropical fusion with tomato sauce, mozzarella, ham, and sweet pineapple chunks.",
      price: 13.99,
      categories: [PizzaCategory.classic],
      tags: [PizzaTag.popular, PizzaTag.bestseller],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBrdl7yJBmMcPFFAz3L8G9bwEFKYg3GNJdxIAHu4qP8uBe9Qz7GBD0CVg2jXuMQ5gyeylCIHyUtiaxPh0vA4SwFq4ryJjC7muzxECt6O3kj4RqGPzBuDGVMUyEhjyt4it-DpKiazQslD7fJJOKZcynfaXa2Naj9-hY3_MBfIYsqLxmKq6QzAQpYxajU66bRe6cUDVnTBuCkMKLVKBXxwE1rqlhapqiOynX5eqTpbIvdfB7d0ROWt3CxzyWYPPUgXlIeh-AfnP-82m2A",
      createdAt: DateTime(2024, 3, 10),
    ),
    Pizza(
      id: 4,
      name: "Marinara Tradizionale",
      description: "Authentic Italian pizza with tomato sauce, garlic, oregano, and extra virgin olive oil.",
      price: 10.99,
      categories: [PizzaCategory.classic, PizzaCategory.vegan],
      tags: [],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuD-SsdZRBl9wrH-3eLTIXGoTX11EVLNCVYntvp8UdVIgcHvQ38AbdX_Yd0p2FEIAP4Lnl8lzuGXMhX4j4bZAJcTyb24MpAx3t7T1E0oGNxTSiw8Ua_oLUdcOG-UVFzrVwGbks3RcaBT0zKda0Chwe7EjdnyrLfJXjoU41StjFt8BntUEIMUQfKe6nO7FlInC75lQYAoo9eQOSQbDIyL11fZR__isKhEqGIZ9NzwmystCOS1Y7d0KqBAXYNc-XqJRtiv6qw0ZXsuI-s_",
      createdAt: DateTime(2024, 2, 5),
    ),
    Pizza(
      id: 5,
      name: "Diavola Piccante",
      description: "Spicy pizza with tomato sauce, mozzarella, and fiery spicy salami.",
      price: 14.99,
      categories: [PizzaCategory.classic, PizzaCategory.spicy],
      tags: [PizzaTag.chefSpecial],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCVDi-9_LecMm6SeNNdIIN9KdHUeXn6BRyGQSD4ybb-3_csq5cAoPp60iVeuH86cXLM7Ve9rpRbS0elB2McFXzxPtBOzLJ_I14JKEdt9odyExUlJpzvua_oJ1cvXB7giiGxLUQE6_OUv0b2DJexfJGKaSFkk0MK4B49aEvHG5e3zp-yIPLELdrAbF-aUHkucJX0g_kLyijc3zpLtQkVgTpTslSbomoiqxlzf5Fqx7jFEWXMsnr1OO_SvRtJLcludsmTnime2hqgNtL9",
      createdAt: DateTime(2024, 4, 20),
    ),
    Pizza(
      id: 6,
      name: "Quattro Formaggi Supreme",
      description: "Rich cheese blend of mozzarella, gorgonzola, parmesan, and creamy provolone.",
      price: 15.99,
      categories: [PizzaCategory.specialty, PizzaCategory.glutenFree],
      tags: [PizzaTag.chefSpecial],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuATc60KNXWy7ikNsywVHyN45SdOG_82gKfoAp9j4dAemydfjjm0wipAf9tJQg1rL_4IXjP42-NikhG1cel-DCwytypP2Gm87N589eR2n2mCyp0t-J5mkY1f8SuhE6RZtUatoeYBppH5HA26Q82Q3vKUekROJClR85fsbbUFn-QBmYLmmocgFwGcgB90QbtDFQhMw12a1FvDCTH3NM_5jmyASWDhgnvimtkts2R5O31h_GqkBjT4Vx9lZegc5tRjGRLMKy-8eHqDRmY-",
      createdAt: DateTime(2024, 5, 12),
    ),
    Pizza(
      id: 7,
      name: "Capricciosa Deluxe",
      description: "Gourmet pizza with tomato sauce, mozzarella, prosciutto, mushrooms, artichokes, and Kalamata olives.",
      price: 16.99,
      categories: [PizzaCategory.specialty],
      tags: [PizzaTag.bestseller],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCZyKurSYt4p9lvXYQxfq-feEkyx7SkAdWmokbV46rNgR0OcCPJOCFtYWccZ6ePzmNEqsd0JdyDyB0WPovHf7TQpNh9O7vH7CN45gXrfbLk7NJomEJyx-vrnatvI290dBuaxcaKTIZejiB32HlyhGlGokDgj2vUTtE_YW9mxGCoXBIwu5V3POcAkWitks8CMEAJe1eKYxpU6Otjd2-7C2GuWJL6cFb4CCRhrybn4cepYFWJ-IjQXuN5wC4Duz7KY4r4j6_-0-BDBeD1",
      createdAt: DateTime(2024, 6, 8),
    ),
    Pizza(
      id: 8,
      name: "Garden Veggie Supreme",
      description: "Fresh vegetable medley with bell peppers, red onions, mushrooms, black olives, and cherry tomatoes on herbed tomato base.",
      price: 13.99,
      categories: [PizzaCategory.specialty, PizzaCategory.vegan],
      tags: [PizzaTag.popular, PizzaTag.chefSpecial],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBYmfVx4LN8rA343zEfsayV1W3o7A1NM5c1gz1T-xIBUc9TzCUM3P9CyNHV6rFCSPcOMyUguuxOe91xD5Ec5gNxW9ytNSeUqdsnjoM1iYbhduVTqIB3zDlMJa4EPo3dRgiR7gVPZP7D2znVYVpWpQ_z2ERkuMyxjAgEjBVuyBLt-7sswBVrGuc3Ld6qGzoIHfgCULimb6xdDBXPEfXdKlcTUrtUj6F8moDKzfcnjXtzSNijuPP3r_Id20eEPTx4NPkZS_R5cUWJ5oYi",
      createdAt: DateTime(2024, 7, 15),
    ),
    Pizza(
      id: 9,
      name: "Buffalo Chicken Inferno",
      description: "Bold and spicy buffalo chicken with red onions, celery, ranch drizzle, and extra hot sauce.",
      price: 17.99,
      categories: [PizzaCategory.specialty, PizzaCategory.spicy],
      tags: [PizzaTag.newItem, PizzaTag.limitedTime],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCVPZBgigWCIxTe6k3hP6dA2dvCag9o-hJMha1lI-c1XDnm-rhwv86mIzFI4iB6cJBdjKBVpYL8MSTosbvORwYXO7O9MNgAy5bQFY7STzEiCEChXp0LpI8oj9pLddbTMmEsWq92KWrRe2R-_0-WZsWSsdo-Fp2EZ62VRVZQKSQ-NmiQJB9qp7rDsady6e32xnkOcTwOLpRTQf4XpabGTYt74o5v_WRFSCI_oVXrGcmr-iriIaHAyi5SCIkv30AdNBx9KnrqpCLRD51u",
      createdAt: DateTime(2024, 11, 20),
    ),
    Pizza(
      id: 10,
      name: "Cauliflower Crust Margherita",
      description: "Health-conscious gluten-free cauliflower crust topped with fresh mozzarella, cherry tomatoes, and aromatic basil.",
      price: 16.99,
      categories: [PizzaCategory.glutenFree, PizzaCategory.specialty],
      tags: [PizzaTag.popular, PizzaTag.chefSpecial],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBYmfVx4LN8rA343zEfsayV1W3o7A1NM5c1gz1T-xIBUc9TzCUM3P9CyNHV6rFCSPcOMyUguuxOe91xD5Ec5gNxW9ytNSeUqdsnjoM1iYbhduVTqIB3zDlMJa4EPo3dRgiR7gVPZP7D2znVYVpWpQ_z2ERkuMyxjAgEjBVuyBLt-7sswBVrGuc3Ld6qGzoIHfgCULimb6xdDBXPEfXdKlcTUrtUj6F8moDKzfcnjXtzSNijuPP3r_Id20eEPTx4NPkZS_R5cUWJ5oYi",
      createdAt: DateTime(2024, 8, 30),
    ),
    Pizza(
      id: 11,
      name: "Mediterranean Delight",
      description: "Sun-dried tomatoes, feta cheese, Kalamata olives, red onions, and fresh oregano on olive oil base.",
      price: 15.49,
      categories: [PizzaCategory.specialty, PizzaCategory.vegan],
      tags: [PizzaTag.chefSpecial],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuATc60KNXWy7ikNsywVHyN45SdOG_82gKfoAp9j4dAemydfjjm0wipAf9tJQg1rL_4IXjP42-NikhG1cel-DCwytypP2Gm87N589eR2n2mCyp0t-J5mkY1f8SuhE6RZtUatoeYBppH5HA26Q82Q3vKUekROJClR85fsbbUFn-QBmYLmmocgFwGcgB90QbtDFQhMw12a1FvDCTH3NM_5jmyASWDhgnvimtkts2R5O31h_GqkBjT4Vx9lZegc5tRjGRLMKy-8eHqDRmY-",
      createdAt: DateTime(2024, 9, 10),
    ),
    Pizza(
      id: 12,
      name: "Truffle Mushroom Elite",
      description: "Premium pizza with truffle oil, wild mushrooms, caramelized onions, and aged parmesan on white sauce base.",
      price: 22.99,
      categories: [PizzaCategory.specialty],
      tags: [PizzaTag.chefSpecial, PizzaTag.limitedTime],
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCZyKurSYt4p9lvXYQxfq-feEkyx7SkAdWmokbV46rNgR0OcCPJOCFtYWccZ6ePzmNEqsd0JdyDyB0WPovHf7TQpNh9O7vH7CN45gXrfbLk7NJomEJyx-vrnatvI290dBuaxcaKTIZejiB32HlyhGlGokDgj2vUTtE_YW9mxGCoXBIwu5V3POcAkWitks8CMEAJe1eKYxpU6Otjd2-7C2GuWJL6cFb4CCRhrybn4cepYFWJ-IjQXuN5wC4Duz7KY4r4j6_-0-BDBeD1",
      createdAt: DateTime(2024, 10, 5),
    ),
  ];
}

// Future implementation for API data source
class ApiPizzaDataSource implements PizzaDataSource {
  final String baseUrl;
  
  const ApiPizzaDataSource(this.baseUrl);

  @override
  Future<List<Pizza>> fetchAllPizzas() async {
    // TODO: Implement HTTP requests
    throw UnimplementedError('API data source not implemented');
  }

  @override
  Future<Pizza?> fetchPizzaById(int id) async {
    // TODO: Implement HTTP requests
    throw UnimplementedError('API data source not implemented');
  }
}