import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch products by category
  Future<List<Map<String, dynamic>>> fetchProductsByCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Products')
          .where('category', isEqualTo: category)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Store the document ID
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  // Fetch favorite products
  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Products')
          .where('isFavorite', isEqualTo: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Store the document ID
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching favorites: $e");
      return [];
    }
  }

  // Toggle favorite status
  Future<void> toggleFavoriteStatus(String productId, bool isFavorite) async {
    try {
      await _firestore.collection('Products').doc(productId).update({
        'isFavorite': isFavorite,
      });
    } catch (e) {
      print("Error updating favorite status: $e");
    }
  }
}