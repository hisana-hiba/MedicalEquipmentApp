import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  double _totalPrice = 0.0;
  Map<String, dynamic> _cartItems = {};

  int get counter => _counter;
  double get totalPrice => _totalPrice;
  Map<String, dynamic> get cartItems => _cartItems;

  Future<void> _setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartCount', _counter);
    prefs.setDouble('totalPrice', _totalPrice);
    prefs.setString('cartItems', jsonEncode(_cartItems));
  }

  Future<void> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cartCount') ?? 0;
    _totalPrice = prefs.getDouble('totalPrice') ?? 0.0;
    String? savedCartItems = prefs.getString('cartItems');
    if (savedCartItems != null) {
      _cartItems = jsonDecode(savedCartItems);
    }
    notifyListeners();
  }

  void addToCart(String productId, String productName, double price, String image) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]['quantity']++;
      _cartItems[productId]['totalPrice'] += price;
    } else {
      _cartItems[productId] = {
        'productName': productName,
        'price': price,
        'quantity': 1,
        'totalPrice': price,
        'image': image,
      };
    }
    _counter++;
    _totalPrice += price;
    _setPrefs();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    if (_cartItems.containsKey(productId)) {
      _totalPrice -= _cartItems[productId]['totalPrice'];
      _cartItems.remove(productId);
      _counter--;
      _setPrefs();
      notifyListeners();
    }
  }

  void updateItemQuantity(String productId, int quantity) {
    if (_cartItems.containsKey(productId)) {
      double pricePerItem = _cartItems[productId]['price'];
      double previousTotalPrice = _cartItems[productId]['totalPrice'];
      if (quantity > 0) {
        _cartItems[productId]['quantity'] = quantity;
        _cartItems[productId]['totalPrice'] = pricePerItem * quantity;
        _totalPrice += _cartItems[productId]['totalPrice'] - previousTotalPrice;
      } else {
        removeFromCart(productId);
      }
      _setPrefs();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _counter = 0;
    _totalPrice = 0.0;
    _setPrefs();
    notifyListeners();
  }

  Future<void> loadCart() async {
    await _getPrefs();
  }
}
