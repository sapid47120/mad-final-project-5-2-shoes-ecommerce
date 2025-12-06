import 'package:shoes_ecommerce_app/providers/cart_provider.dart';

class Order {
  final String id;
  final List<CartItem> products;
  final double totalAmount;
  final String shippingAddress;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.products,
    required this.totalAmount,
    required this.shippingAddress,
    required this.orderDate,
  });
}
