class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingMap = (json['rating'] as Map<String, dynamic>?) ?? {};
    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'No title',
      // API may return 109 (int) or 109.95 (double) -> num is safe
      price: (json['price'] as num? ?? 0).toDouble(),
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'unknown',
      imageUrl: json['image'] as String? ?? '',
      rating: (ratingMap['rate'] as num? ?? 0).toDouble(),
      reviewCount: (ratingMap['count'] as num? ?? 0).toInt(),
    );
  }

  /// FakeStore gives only one image per product, so the gallery
  /// is built from it (3 pages) to demonstrate the carousel.
  List<String> get gallery => [imageUrl, imageUrl, imageUrl];
}
