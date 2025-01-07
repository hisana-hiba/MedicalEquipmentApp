import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Placed"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          "Your order has been placed successfully!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}