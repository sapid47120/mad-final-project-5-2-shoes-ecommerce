// lib/screens/place_order_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  final double totalAmount;

  PlaceOrderScreen({required this.totalAmount});

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _mobile = '';
  String _address = '';

  bool _isPlacingOrder = false;

  void _submitOrder(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isPlacingOrder = true);

      await Future.delayed(Duration(seconds: 2));

      final cart = Provider.of<CartProvider>(context, listen: false);
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);

      orderProvider.addOrder(
        name: _name,
        mobile: _mobile,
        address: _address,
        items: cart.items,
        total: widget.totalAmount,
      );

      cart.clearCart();

      setState(() => _isPlacingOrder = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Place Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Enter your details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                onSaved: (val) => _name = val!,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                onSaved: (val) => _mobile = val!,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                maxLines: 3,
                onSaved: (val) => _address = val!,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              Text('Total: \$${widget.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                child: _isPlacingOrder
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Confirm Order'),
                onPressed: _isPlacingOrder ? null : () => _submitOrder(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
