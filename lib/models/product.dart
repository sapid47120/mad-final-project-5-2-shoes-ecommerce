// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final List<String> categories;
  final List<int> availableSizes;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.categories = const ['All'],
    this.availableSizes = const [7, 8, 9, 10, 11],
    this.rating = 4.5,
    this.reviewCount = 120,
  });
}