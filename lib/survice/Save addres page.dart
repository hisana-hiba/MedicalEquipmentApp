import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Check out page.dart';
import '../PAYMENT CODE WITH COD.dart';
// Update the import path as per your file structure

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({Key? key}) : super(key: key);

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final Color tealColor = Colors.teal;
    final Color whiteColor = Colors.white;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Saved Addresses"),
        backgroundColor: tealColor,
        elevation: 2,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('addresses')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No addresses saved yet."));
          }

          final addresses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    "${address['name']} - ${address['phone']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${address['house']}, ${address['road']}, ${address['pincode']}",
                  ),
                  trailing: address['isDefault']
                      ? Icon(Icons.check_circle, color: tealColor)
                      : null,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(cartItems: {}, totalPrice: 0.0, address: '',)));
                    // Optionally handle address selection
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tealColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(
                cartItems: {}, // Pass actual cart items if needed
                totalPrice: 0.0, // Pass actual total price if needed
              ),
            ),
          );

          if (result == true) {
            setState(() {}); // Refresh the saved addresses list
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
