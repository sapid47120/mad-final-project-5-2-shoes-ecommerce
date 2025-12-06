// lib/widgets/cart_item.dart
import 'package:flutter/material.dart';
import '../models/product.dart'; // Import Product model for cart items

class CartItem extends StatelessWidget {
  final Product cartItem;

  const CartItem({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        cartItem.imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(cartItem.name),
      subtitle: Text('\$${cartItem.price.toStringAsFixed(2)}'),
    );
  }
}
