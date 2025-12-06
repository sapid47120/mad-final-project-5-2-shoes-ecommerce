import 'package:flutter/material.dart';
import 'home_screen.dart';  // make sure this path is correct

class ThankYouScreen extends StatelessWidget {
  final double totalAmount;
  final String name;
  final String phone;
  final String address;
  final String paymentMethod;

  ThankYouScreen({
    required this.totalAmount,
    required this.name,
    required this.phone,
    required this.address,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Intercept system back button
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false,
        );
        return false; // prevent default back behavior
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Order Confirmed")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 100),
                SizedBox(height: 20),
                Text(
                  'Thank you, $name!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('Your order has been placed successfully!'),
                SizedBox(height: 20),
                Text('📞 Phone: $phone'),
                Text('🏠 Address: $address'),
                Text('💳 Payment Method: $paymentMethod'),
                SizedBox(height: 10),
                Text(
                  '💵 Total Paid: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: Icon(Icons.home),
                  label: Text('Back to Home'),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
