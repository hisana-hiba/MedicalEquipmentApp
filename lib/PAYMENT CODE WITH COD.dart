import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'adres/OrderplacedScreen.dart';



class PaymentPage extends StatelessWidget {
  final Map<String, dynamic> cartItems;
  final double totalPrice;
  final String address;


  // Constructor to receive the cart items, total price, address, and size
  PaymentPage({
    required this.cartItems,
    required this.totalPrice,
    required this.address,

  });

  // Function to place the order
  void placeOrder(BuildContext context) async {
    if (cartItems.isEmpty) return;

    final orderData = cartItems.values.map((item) {
      return {
        'productName': item['productName'],
        'price': item['price'],
        'quantity': item['quantity'],
        'totalPrice': item['totalPrice'],
        'imageUrl': item['image'],
      };
    }).toList();

    await FirebaseFirestore.instance.collection('orders').add({
      'items': orderData,
      'totalPrice': totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
      'address': address,  // Add user-provided address
               // Store selected size
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order placed successfully!')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPlacedScreen(),
      ),
    );
  }


  // Function to show the Cash on Delivery confirmation dialog
  void _showCODConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Order'),
        content: Text('Do you want to place the order via Cash on Delivery?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              placeOrder(context);
              // Call placeOrder when confirmed
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add Razorpay integration here
              },
              child: Text('Pay Online'),
            ),
            ElevatedButton(
              onPressed: () => _showCODConfirmation(context),
              child: Text('Cash on Delivery'),
            ),
          ],
        ),
      ),
    );
  }
}