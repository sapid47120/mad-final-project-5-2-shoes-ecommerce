// Inside lib/models/order_item.dart

class OrderItem {
  final String id;
  final List<Map<String, dynamic>> products;
  final double amount;
  final DateTime dateTime;
  final String userId;

  OrderItem({
    required this.id,
    required this.products,
    required this.amount,
    required this.dateTime,
    required this.userId,
  });

  // Add a getter for total amount (same as amount)
  double get total => amount;

  // Method to convert OrderItem to Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products,
      'amount': amount,
      'dateTime': dateTime.toIso8601String(),
      'userId': userId,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] ?? '',
      products: List<Map<String, dynamic>>.from(map['products']),
      amount: map['amount']?.toDouble() ?? 0.0,
      dateTime: DateTime.parse(map['dateTime']),
      userId: map['userId'] ?? '',
    );
  }
}
