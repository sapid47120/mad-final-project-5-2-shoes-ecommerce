// lib/providers/order_provider.dart
import 'package:flutter/material.dart';
import 'cart_provider.dart';

class Order {
  final String name;
  final String mobile;
  final String address;
  final List<CartItem> items;
  final double total;
  final DateTime timestamp;

  Order({
    required this.name,
    required this.mobile,
    required this.address,
    required this.items,
    required this.total,
    required this.timestamp,
  });
}

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder({
    required String name,
    required String mobile,
    required String address,
    required List<CartItem> items,
    required double total,
  }) {
    _orders.insert(
      0,
      Order(
        name: name,
        mobile: mobile,
        address: address,
        items: List.from(items),
        total: total,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
