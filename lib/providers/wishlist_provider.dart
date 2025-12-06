// lib/providers/wishlist_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider with ChangeNotifier {
  final List<Product> _wishlistItems = [];

  List<Product> get wishlistItems => _wishlistItems;

  void addToWishlist(Product product) {
    if (!_wishlistItems.any((item) => item.id == product.id)) {
      _wishlistItems.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    _wishlistItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  bool isInWishlist(Product product) {
    return _wishlistItems.any((item) => item.id == product.id);
  }
}