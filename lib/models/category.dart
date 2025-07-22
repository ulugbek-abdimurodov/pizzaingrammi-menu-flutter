class Category {
  final String id;
  final String name;
  final String iconUrl;
  final int itemCount;

  Category({
    required this.id,
    required this.name,
    required this.iconUrl,
    this.itemCount = 0,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      iconUrl: json['iconUrl'],
      itemCount: json['itemCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconUrl': iconUrl,
      'itemCount': itemCount,
    };
  }
}