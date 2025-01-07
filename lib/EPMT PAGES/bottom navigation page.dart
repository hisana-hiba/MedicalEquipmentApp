import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:untitled42/Profile%20screens/profile%20page.dart';
import 'package:untitled42/EPMT%20PAGES/view%20category.dart';
import '../cart/cart provider.dart';
import '../cart/cart ui.dart';
import 'home surg.dart';

import '../cart/cart service.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final List<Widget> pages = [
    SurgHome(),
    CategoryPage(),
    CartScreen(),
    ProfilePage(),
  ];

  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return SalomonBottomBar(
            currentIndex: currentTabIndex,
            onTap: (index) {
              setState(() {
                currentTabIndex = index;
              });
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Colors.teal,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.category),
                title: const Text("Category"),
                selectedColor: Colors.teal,
              ),
              SalomonBottomBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cartProvider.counter > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            cartProvider.counter.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                title: const Text("Cart"),
                selectedColor: Colors.teal,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text("Accounts"),
                selectedColor: Colors.teal,
              ),
            ],
          );
        },
      ),
    );
  }
}
