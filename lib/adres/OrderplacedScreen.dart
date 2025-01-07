import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Placed'),
      ),
      body: Center(
        child: Text(
          'Your order has been placed successfully!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}