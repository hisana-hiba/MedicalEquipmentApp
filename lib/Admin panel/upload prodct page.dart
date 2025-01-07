import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadedProductsPage extends StatefulWidget {
  @override
  _UploadedProductsPageState createState() => _UploadedProductsPageState();
}

class _UploadedProductsPageState extends State<UploadedProductsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUploadedProducts();
  }

  Future<void> fetchUploadedProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Products').get();
      final products = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Save the document ID for deletion
        return data;
      }).toList();

      setState(() {
        allProducts = products;
        filteredProducts = products; // Initially display all products
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void searchProducts(String query) {
    final suggestions = allProducts.where((product) {
      final productName = product['name'].toString().toLowerCase();
      final input = query.toLowerCase();
      return productName.contains(input);
    }).toList();

    setState(() {
      filteredProducts = suggestions;
    });
  }

  void deleteProduct(String productId) async {
    try {
      await _firestore.collection('Products').doc(productId).delete();
      setState(() {
        filteredProducts.removeWhere((product) => product['id'] == productId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product deleted")),
      );
    } catch (e) {
      print("Error deleting product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete product")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploaded Products"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: searchProducts,
            ),
          ),
        ),
      ),
      body: filteredProducts.isEmpty
          ? Center(
        child: Text(
          "No products found",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          final double price = product['price'];
          final double discount = product['discount'] ?? 0.0;
          final double discountedPrice = price - (price * (discount / 100));

          return ListTile(
            leading: product['image'] != ''
                ? Image.network(
              product['image'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image, size: 50),
            title: Text(product['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("₹$price", style: TextStyle(decoration: TextDecoration.lineThrough)),
                Text("Discounted: ₹$discountedPrice", style: TextStyle(color: Colors.green)),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteProduct(product['id']),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}