class FavoritePackage {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String tagline;
  
  FavoritePackage({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.tagline,
  });
  
  // Convert to and from Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'tagline': tagline,
    };
  }
  
  factory FavoritePackage.fromMap(Map<String, dynamic> map) {
    return FavoritePackage(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      price: map['price'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      tagline: map['tagline'] ?? '',
    );
  }
}
