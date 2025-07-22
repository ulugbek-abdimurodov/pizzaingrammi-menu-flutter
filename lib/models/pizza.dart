class Pizza {
  final String id;
  final String category;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> tags;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isPopular;
  final bool isNew;

  Pizza({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.tags = const [],
    this.isGlutenFree = false,
    this.isVegan = false,
    this.isPopular = false,
    this.isNew = false,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      tags: List<String>.from(json['tags'] ?? []),
      isGlutenFree: json['isGlutenFree'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isPopular: json['isPopular'] ?? false,
      isNew: json['isNew'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'tags': tags,
      'isGlutenFree': isGlutenFree,
      'isVegan': isVegan,
      'isPopular': isPopular,
      'isNew': isNew,
    };
  }

  bool matchesSearch(String query) {
    final searchQuery = query.toLowerCase();
    return title.toLowerCase().contains(searchQuery) ||
        description.toLowerCase().contains(searchQuery) ||
        category.toLowerCase().contains(searchQuery);
  }
}