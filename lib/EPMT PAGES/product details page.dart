import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/cart provider.dart';
import '../cart/cart service.dart';

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final String description;

  const ProductDetailsPage({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required productId, required productData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(image),
              SizedBox(height: 16.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "₹$price",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final cartService = Provider.of<CartProvider>(context, listen: false);
                      cartService.addToCart(
                        DateTime.now().toString(), // Using current time as unique product ID
                        name,
                        price,
                        image,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$name added to cart')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: Text("Add to Cart"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Proceeding to buy $name')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: Text("Buy Now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
