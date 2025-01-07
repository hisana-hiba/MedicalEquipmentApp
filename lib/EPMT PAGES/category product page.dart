import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled42/EPMT%20PAGES/product%20details%20page.dart';

import 'category helper.dart';

class CategoryProductsPage extends StatelessWidget {
  final String category;
  final FirebaseService _firebaseService = FirebaseService();

  CategoryProductsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$category Products")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _firebaseService.fetchProductsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading products"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products available in this category"));
          }

          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductTile(
                id: product['id'],
                name: product['name'],
                image: product['image'],
                price: product['price'],
                description: product['description'],
                isFavorite: product['isFavorite'] ?? false,
              );
            },
          );
        },
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final bool isFavorite;

  const ProductTile({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.isFavorite,
  });

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    FirebaseService().toggleFavoriteStatus(widget.id, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              name: widget.name,
              image: widget.image,
              price: widget.price,
              description: widget.description,
              productId:widget.id, productData: '' ,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(widget.image, height: 100, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("₹${widget.price}"),
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: toggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}