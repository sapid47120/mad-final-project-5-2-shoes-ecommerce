class OrderModel {
  final String orderId;
  final String userId;
  final String customerName;
  final String phoneNumber;
  final String address;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final DateTime orderDate;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'address': address,
      'items': items,
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'],
      userId: map['userId'],
      customerName: map['customerName'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      items: List<Map<String, dynamic>>.from(map['items']),
      totalAmount: map['totalAmount'],
      orderDate: DateTime.parse(map['orderDate']),
    );
  }
}
