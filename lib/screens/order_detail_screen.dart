// Inside lib/screens/order_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/order_item.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderItem order;

  OrderDetailScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: Column(
        children: [
          Text('Order ID: ${order.id}'),
          Text('Date: ${order.dateTime.toLocal()}'),
          Text('Total: \$${order.total.toStringAsFixed(2)}'), // Using total
          // Add other order details here
        ],
      ),
    );
  }
}
