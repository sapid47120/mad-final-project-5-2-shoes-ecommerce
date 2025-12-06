// lib/widgets/product_tile.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart'; // Make sure this import is correct

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.asset(
          product.imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product: product),
          ));
        },
      ),
    );
  }
}
