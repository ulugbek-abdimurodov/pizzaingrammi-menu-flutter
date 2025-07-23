import 'package:equatable/equatable.dart';
import '../../core/enums/app_enums.dart';

class Pizza extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final List<PizzaCategory> categories;
  final List<PizzaTag> tags;
  final String imageUrl;
  final bool isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const Pizza({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.currency = '€',
    required this.categories,
    this.tags = const [],
    required this.imageUrl,
    this.isAvailable = true,
    this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? '€',
      categories: (json['category'] as List<dynamic>?)
          ?.map((cat) => PizzaCategory.fromString(cat as String))
          .toList() ?? [],
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tag) => PizzaTag.fromString(tag as String))
          .where((tag) => tag != null)
          .cast<PizzaTag>()
          .toList() ?? [],
      imageUrl: json['image'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'category': categories.map((cat) => cat.name).toList(),
      'tags': tags.map((tag) => tag.value).toList(),
      'image': imageUrl,
      'isAvailable': isAvailable,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  Pizza copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? currency,
    List<PizzaCategory>? categories,
    List<PizzaTag>? tags,
    String? imageUrl,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Pizza(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  // Business Logic Methods
  bool matchesSearch(String query) {
    if (query.isEmpty) return true;
    
    final searchTerm = query.toLowerCase();
    return name.toLowerCase().contains(searchTerm) ||
        description.toLowerCase().contains(searchTerm) ||
        categories.any((cat) => cat.displayName.toLowerCase().contains(searchTerm)) ||
        tags.any((tag) => tag.displayName.toLowerCase().contains(searchTerm));
  }

  bool hasCategory(PizzaCategory category) {
    if (category == PizzaCategory.all) return true;
    return categories.contains(category);
  }

  bool hasTag(PizzaTag tag) {
    return tags.contains(tag);
  }

  bool hasAnyCategory(List<PizzaCategory> searchCategories) {
    if (searchCategories.contains(PizzaCategory.all)) return true;
    return categories.any((cat) => searchCategories.contains(cat));
  }

  bool hasAnyTag(List<PizzaTag> searchTags) {
    if (searchTags.isEmpty) return true;
    return tags.any((tag) => searchTags.contains(tag));
  }

  // Convenience Getters
  String get formattedPrice => '$currency${price.toStringAsFixed(2)}';
  
  bool get isPopular => tags.contains(PizzaTag.popular);
  bool get isNew => tags.contains(PizzaTag.newItem);
  bool get isBestseller => tags.contains(PizzaTag.bestseller);
  bool get isChefSpecial => tags.contains(PizzaTag.chefSpecial);
  bool get isLimitedTime => tags.contains(PizzaTag.limitedTime);
  
  bool get isClassic => categories.contains(PizzaCategory.classic);
  bool get isSpecialty => categories.contains(PizzaCategory.specialty);
  bool get isVegan => categories.contains(PizzaCategory.vegan);
  bool get isGlutenFree => categories.contains(PizzaCategory.glutenFree);
  bool get isSpicy => categories.contains(PizzaCategory.spicy);

  List<PizzaTag> get displayTags => tags.take(2).toList(); // Show max 2 tags
  
  String get primaryCategory => categories.isNotEmpty 
      ? categories.first.displayName 
      : PizzaCategory.classic.displayName;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    currency,
    categories,
    tags,
    imageUrl,
    isAvailable,
    createdAt,
    updatedAt,
    metadata,
  ];

  @override
  String toString() {
    return 'Pizza(id: $id, name: $name, price: $formattedPrice, '
           'categories: ${categories.map((c) => c.name).join(', ')}, '
           'tags: ${tags.map((t) => t.value).join(', ')})';
  }
}