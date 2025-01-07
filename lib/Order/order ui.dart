import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final CollectionReference orders =
  FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error loading orders'));
          }

          // Show loading indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Extract order documents
          final orderDocs = snapshot.data?.docs;

          // Handle no orders
          if (orderDocs == null || orderDocs.isEmpty) {
            return Center(child: Text('No orders placed'));
          }

          return ListView.builder(
            itemCount: orderDocs.length,
            itemBuilder: (context, index) {
              final order = orderDocs[index];
              final orderData = order.data() as Map<String, dynamic>?;

              // Handle null or invalid order data
              if (orderData == null) {
                return ListTile(
                  title: Text('Invalid order data'),
                  subtitle: Text('Order ID: ${order.id}'),
                );
              }

              // Extract and validate order details
              final totalPrice = orderData['totalPrice'] ?? 0.0;
              final address = orderData['address'] ?? 'No address provided';

              final items = orderData['items'] as List<dynamic>? ?? [];

              return Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Total: \$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Address: $address'),

                      SizedBox(height: 10),
                      if (items.isEmpty)
                        Text(
                          'No items in this order',
                          style: TextStyle(color: Colors.red),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, itemIndex) {
                            final item = items[itemIndex] as Map<String, dynamic>?;

                            // Handle invalid item data
                            if (item == null) {
                              return ListTile(
                                title: Text('Invalid item'),
                              );
                            }

                            final imageUrl = item['imageUrl'] ?? '';
                            final productName = item['productName'] ?? 'Unknown';
                            final quantity = item['quantity'] ?? 0;
                            final price = item['price'] ?? 0.0;

                            return ListTile(
                              leading: imageUrl.isNotEmpty
                                  ? Image.network(
                                imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                                  : Icon(Icons.image_not_supported),
                              title: Text(productName),
                              subtitle: Text(
                                  'Quantity: $quantity - Price: \$${price.toStringAsFixed(2)}'),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}