import 'package:flutter/material.dart';

class CartService extends ChangeNotifier {
  // List to store the products added to the cart
  List<Map<String, dynamic>> _cartItems = [];

  // Getter to access the cart items
  List<Map<String, dynamic>> get cartItems => _cartItems;

  // Add product to the cart
  void addToCart(Map<String, dynamic> product) {
    _cartItems.add(product);  // Add the product to the list
    notifyListeners();  // Notify listeners about the change
  }

  // Remove product from the cart
  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.remove(product);  // Remove the product from the list
    notifyListeners();  // Notify listeners about the change
  }

  // Get the total price of the items in the cart
  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item['price']);
  }

  // Get the count of items in the cart
  int get itemCount => _cartItems.length;
}
