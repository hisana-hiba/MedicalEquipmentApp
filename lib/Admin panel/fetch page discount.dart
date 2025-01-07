import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled42/Admin%20panel/upload%20prodct%20page.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountController = TextEditingController(); // Discount field
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
    final String name = _nameController.text;
    final String image = _imageController.text;
    final double price = double.parse(_priceController.text);
    final String description = _descriptionController.text;
    final double discount = _discountController.text.isNotEmpty
        ? double.parse(_discountController.text)
        : 0.0; // Default to 0 if empty

    // Calculate the discounted price
    double discountedPrice = price - (price * (discount / 100));

    await FirebaseFirestore.instance.collection('Products').add({
      'name': name,
      'image': image,
      'price': discountedPrice,
      'description': description,
      'category': _selectedCategory,
      'discount': discount, // Save the discount percentage
      'isFavorite': false, // Add the favorite field
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Product added successfully!")),
    );

    _nameController.clear();
    _imageController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _discountController.clear();
  }

  void _deleteProduct(String productId) async {
    await FirebaseFirestore.instance.collection('Products').doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product deleted successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Panel")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: "Image URL"),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: _discountController,
              decoration: InputDecoration(labelText: "Discount (%)"),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text("Add Product"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListedProductsPage()),
                );
              },
              child: Text("Listed Products"),
            ),
          ],
        ),
      ),
    );
  }
}

class ListedProductsPage extends StatelessWidget {
  final CollectionReference products = FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listed Products"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: products.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error loading products'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final productDocs = snapshot.data?.docs;

          if (productDocs == null || productDocs.isEmpty) {
            return Center(child: Text('No products listed'));
          }

          return ListView.builder(
            itemCount: productDocs.length,
            itemBuilder: (context, index) {
              final product = productDocs[index];
              final productData = product.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    productData['image'] ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(productData['name'] ?? 'No Name'),
                  subtitle: Text('₹${productData['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Delete the product from Firestore
                      _deleteProduct(product.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _deleteProduct(String productId) async {
    await FirebaseFirestore.instance.collection('Products').doc(productId).delete();
  }
}