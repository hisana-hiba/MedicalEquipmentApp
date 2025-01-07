import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category product page.dart';

// Import the CategoryProductsPage

class CategoryPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"image": "assets/image/HOSPITAL INTRUMENTS.jpg", "name": "HOSPITAL INSTRUMENTS"},
    {"image": "assets/image/3 M PRODUCTS.jpg", "name": "3 M PRODUCTS"},
    {"image": "assets/image/DISINFECTION SOLUTIONS.jpg", "name": "DISINFECTION SOLUTIONS"},
    {"image": "assets/image/ORTHOPAEDIC PRODUCTS.jpg", "name": "ORTHOPAEDIC PRODUCTS"},
    {"image": "assets/image/SURGICAL EQUIPMENTS.jpg", "name": "SURGICAL EQUIPMENTS"},
    {"image": "assets/image/HOSPITAL FURNITURE.jpg", "name": "HOSPITAL FURNITURE"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryTile(
              image: categories[index]["image"]!,
              name: categories[index]["name"]!,
            );
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image;
  final String name;

  const CategoryTile({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to CategoryProductsPage and pass the selected category name
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsPage(category: name), // Pass category name
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Image.asset(
              image,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}