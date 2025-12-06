// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  final int size;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0, (sum, item) {
      return sum + (item.product.price * item.quantity);
    });
  }

  void addItem(Product product, int size) {
    final existingIndex = _items.indexWhere(
          (item) => item.product.id == product.id && item.size == size,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product, size: size));
    }
    notifyListeners();
  }

  void removeItem(String productId, int size) {
    _items.removeWhere((item) => item.product.id == productId && item.size == size);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}