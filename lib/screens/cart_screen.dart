import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'thank_you_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showForm = false;
  bool _isProcessing = false;

  String _name = '';
  String _phone = '';
  String _address = '';
  String _paymentMethod = 'Cash on Delivery';

  final List<String> _paymentMethods = [
    'Cash on Delivery',
    'Credit Card',
    'Debit Card',
    'EasyPaisa',
    'JazzCash',
  ];

  Future<void> _simulatePaymentProcess() async {
    // Simulate different delays for payment methods
    switch (_paymentMethod) {
      case 'Cash on Delivery':
      // No actual payment processing delay for COD
        await Future.delayed(Duration(seconds: 1));
        break;
      case 'Credit Card':
      case 'Debit Card':
      // Simulate online card payment delay
        await Future.delayed(Duration(seconds: 3));
        break;
      case 'EasyPaisa':
      case 'JazzCash':
      // Simulate mobile wallet payment delay
        await Future.delayed(Duration(seconds: 2));
        break;
      default:
        await Future.delayed(Duration(seconds: 1));
    }
  }

  void _submitOrder(BuildContext context, double totalAmount) async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate payment process
      await _simulatePaymentProcess();

      // Clear the cart
      Provider.of<CartProvider>(context, listen: false).clearCart();

      setState(() {
        _isProcessing = false;
      });

      // Navigate to Thank You screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ThankYouScreen(
            totalAmount: totalAmount,
            name: _name,
            phone: _phone,
            address: _address,
            paymentMethod: _paymentMethod,
          ),
        ),
      );
    } catch (error) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;
    final totalAmount = cart.totalAmount;

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(
                    item.product.imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Size: ${item.size}'),
                      Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (item.quantity > 1) {
                            setState(() => item.quantity--);
                            cart.notifyListeners();
                          } else {
                            cart.removeItem(item.product.id, item.size);
                          }
                        },
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() => item.quantity++);
                          cart.notifyListeners();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cart.removeItem(item.product.id, item.size);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          if (_showForm)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) =>
                      value!.isEmpty ? 'Enter your name' : null,
                      onSaved: (value) => _name = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                      value!.isEmpty ? 'Enter phone number' : null,
                      onSaved: (value) => _phone = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) =>
                      value!.isEmpty ? 'Enter address' : null,
                      onSaved: (value) => _address = value!,
                    ),
                    DropdownButtonFormField<String>(
                      value: _paymentMethod,
                      items: _paymentMethods
                          .map(
                            (method) => DropdownMenuItem(
                          child: Text(method),
                          value: method,
                        ),
                      )
                          .toList(),
                      decoration:
                      InputDecoration(labelText: 'Payment Method'),
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                      onSaved: (value) => _paymentMethod = value!,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _isProcessing
                          ? null
                          : () => _submitOrder(context, totalAmount),
                      child: _isProcessing
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : Text('Submit Order'),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: !_showForm && cartItems.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _showForm = true;
            });
          },
          child: Text('Checkout'),
        ),
      )
          : null,
    );
  }
}
