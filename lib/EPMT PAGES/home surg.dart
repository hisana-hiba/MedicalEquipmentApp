import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled42/EPMT%20PAGES/product%20details%20page.dart';
import 'package:untitled42/EPMT%20PAGES/search%20page.dart';
import 'package:untitled42/EPMT%20PAGES/support%20widget.dart';
import 'package:untitled42/EPMT%20PAGES/whishlist%20page.dart';

class SurgHome extends StatefulWidget {
  const SurgHome({super.key});

  @override
  State<SurgHome> createState() => _SurgHomeState();
}

class _SurgHomeState extends State<SurgHome> {
  final List<String> carouselImages = [
    'assets/image/sale.jpg',
    'assets/image/OIP.jpg',
    'assets/image/discount.jpg',
  ];

  List<Map<String, dynamic>> products = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Products')
          .limit(4) // Fetch only 4 products
          .get();

      final List<Map<String, dynamic>> fetchedProducts = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add document ID for potential further operations
        return data;
      }).toList();

      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          "EQUIPMED",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications action
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find an item and explore the app",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  decoration: InputDecoration(
                    hintText: "Search Product",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.teal),
                  ),
                ),
              ),
              SizedBox(height: 15),
              CarouselSlider(
                items: carouselImages.map((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Products",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 230,
                child: products.isEmpty
                    ? Center(child: Text("No products available"))
                    : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              name: product['name'] ?? '',
                              image: product['image'] ?? '',
                              price: product['price'] ?? 0,
                              description: product['description'] ?? '',
                              productId: product['id'], productData: '',
                            ),
                          ),
                        );
                      },
                      child: buildProductCard(
                        product['image'] ?? 'assets/image/default.jpg',
                        product['name'] ?? 'Product Name',
                        product['price']?.toString() ?? '0',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCard(String image, String name, String price) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CupertinoColors.white,
      ),
      child: Column(
        children: [
          Center(
            child: Image.network(
              image,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: AppWidget.semiBoldTextFieldStyle(),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.currency_rupee_outlined),
              Text(price),
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.add,
                  color: CupertinoColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}