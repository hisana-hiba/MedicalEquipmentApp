import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Order/order ui.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  String _selectedCategory = "HOSPITAL INSTRUMENTS";

  final List<String> _categories = [
    "HOSPITAL INSTRUMENTS",
    "3 M PRODUCTS",
    "DISINFECTION SOLUTIONS",
    "ORTHOPAEDIC PRODUCTS",
    "SURGICAL EQUIPMENTS",
    "HOSPITAL FURNITURE",
  ];

  void _addProduct() async {
    final String name = _nameController.text.trim();
    final String image = _imageController.text.trim();
    final double? price = double.tryParse(_priceController.text.trim());
    final String description = _descriptionController.text.trim();
    final double? discount = _discountController.text.isNotEmpty
        ? double.tryParse(_discountController.text.trim())
        : null;

    if (name.isEmpty || image.isEmpty || price == null || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields!")),
      );
      return;
    }

    try {
      double discountedPrice = price - (price * (discount ?? 0) / 100);

      await FirebaseFirestore.instance.collection('Products').add({
        'name': name,
        'image': image,
        'price': discountedPrice,
        'description': description,
        'category': _selectedCategory,
        'discount': discount ?? 0.0,
        'isFavorite': false,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product added successfully!")),
      );

      _nameController.clear();
      _imageController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _discountController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add product: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: "Discount (%)"),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: const Text("Add Product"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersPage()),
                  );
                },
                child: const Text("View Orders"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class OrdersPage extends StatelessWidget {
//   final CollectionReference orders =
//   FirebaseFirestore.instance.collection('orders');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Orders"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: orders.snapshots(),
//         builder: (context, snapshot) {
//           // Handle errors
//           if (snapshot.hasError) {
//             return Center(child: Text('Error loading orders'));
//           }
//
//           // Show loading indicator
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           // Extract order documents
//           final orderDocs = snapshot.data?.docs;
//
//           // Handle no orders
//           if (orderDocs == null || orderDocs.isEmpty) {
//             return Center(child: Text('No orders placed'));
//           }
//
//           return ListView.builder(
//             itemCount: orderDocs.length,
//             itemBuilder: (context, index) {
//               final order = orderDocs[index];
//               final orderData = order.data() as Map<String, dynamic>?;
//
//               // Handle null or invalid order data
//               if (orderData == null) {
//                 return ListTile(
//                   title: Text('Invalid order data'),
//                   subtitle: Text('Order ID: ${order.id}'),
//                 );
//               }
//
//               // Extract and validate order details
//               final totalPrice = orderData['totalPrice'] ?? 0.0;
//               final address = orderData['address'] ?? 'No address provided';
//               final size = orderData['size'] ?? 'No size selected'; // Get the size
//               final items = orderData['items'] as List<dynamic>? ?? [];
//
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Order Total: \$${totalPrice.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text('Address: $address'),
//                       SizedBox(height: 10),
//                       Text('Size: $size'),  // Display the selected size
//                       SizedBox(height: 10),
//                       if (items.isEmpty)
//                         Text(
//                           'No items in this order',
//                           style: TextStyle(color: Colors.red),
//                         )
//                       else
//                         ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: items.length,
//                           itemBuilder: (context, itemIndex) {
//                             final item = items[itemIndex] as Map<String, dynamic>?;
//
//                             // Handle invalid item data
//                             if (item == null) {
//                               return ListTile(
//                                 title: Text('Invalid item'),
//                               );
//                             }
//
//                             final imageUrl = item['imageUrl'] ?? '';
//                             final productName = item['productName'] ?? 'Unknown';
//                             final quantity = item['quantity'] ?? 0;
//                             final price = item['price'] ?? 0.0;
//
//                             return ListTile(
//                               leading: imageUrl.isNotEmpty
//                                   ? Image.network(
//                                 imageUrl,
//                                 width: 50,
//                                 height: 50,
//                                 fit: BoxFit.cover,
//                               )
//                                   : Icon(Icons.image_not_supported),
//                               title: Text(productName),
//                               subtitle: Text(
//                                   'Quantity: $quantity - Price: \$${price.toStringAsFixed(2)}'),
//                             );
//                           },
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }