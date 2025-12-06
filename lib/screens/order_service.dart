// services/order_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';  // adjust the path if needed

class OrderService {
  // Static function to place an order
  static Future<void> placeOrder({
    required String name,
    required String phone,
    required String address,
    required List<Map<String, dynamic>> cartItems,
    required double total,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final orderId = FirebaseFirestore.instance.collection('orders').doc().id;

    final newOrder = OrderModel(
      orderId: orderId,
      userId: user.uid,
      customerName: name,
      phoneNumber: phone,
      address: address,
      items: cartItems,
      totalAmount: total,
      orderDate: DateTime.now(),
    );

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .set(newOrder.toMap());
  }
}
