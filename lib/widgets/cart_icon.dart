// lib/widgets/cart_icon.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => CartScreen(),
            ));
          },
        ),
        if (cart.itemCount > 0)
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              constraints: BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '${cart.itemCount}',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ],
    );
  }
}
