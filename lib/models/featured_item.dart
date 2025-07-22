class FeaturedItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? actionUrl;
  final DateTime? validUntil;

  FeaturedItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.actionUrl,
    this.validUntil,
  });

  factory FeaturedItem.fromJson(Map<String, dynamic> json) {
    return FeaturedItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      actionUrl: json['actionUrl'],
      validUntil: json['validUntil'] != null 
          ? DateTime.parse(json['validUntil'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'actionUrl': actionUrl,
      'validUntil': validUntil?.toIso8601String(),
    };
  }

  bool get isValid {
    if (validUntil == null) return true;
    return DateTime.now().isBefore(validUntil!);
  }
}