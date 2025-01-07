import 'package:flutter/material.dart';

import 'PAYMENT CODE WITH COD.dart';


class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> cartItems;
  final double totalPrice;

  CheckoutPage({required this.cartItems, required this.totalPrice});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _addressController = TextEditingController();
  String address = '';
 // Size selection field

  // Function to navigate to the payment page
  void navigateToPaymentPage() {
    address = _addressController.text.trim();

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your address')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          cartItems: widget.cartItems,
          totalPrice: widget.totalPrice,
          address: address,
          // Pass the selected size
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Address Input Field
            Text(
              'Enter your address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),


            SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigateToPaymentPage,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.green,
              ),
              child: Text(
                'Proceed to Payment',
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
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:untitled42/survice/Save%20addres%20page.dart';
//
// // Import SavedAddressesPage
//
// class AddAddressPage extends StatefulWidget {
//   final Map<String, dynamic> cartItems;
//   final double totalPrice;
//
//   const AddAddressPage({
//     Key? key,
//     required this.cartItems,
//     required this.totalPrice,
//   }) : super(key: key);
//
//   @override
//   State<AddAddressPage> createState() => _AddAddressPageState();
// }
//
// class _AddAddressPageState extends State<AddAddressPage> {
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _houseController = TextEditingController();
//   final TextEditingController _roadController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   bool _isDefaultAddress = false;
//
//   Future<void> _saveAddress() async {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       final addressesCollection = FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('addresses');
//
//       await addressesCollection.add({
//         'pincode': _pincodeController.text.trim(),
//         'house': _houseController.text.trim(),
//         'road': _roadController.text.trim(),
//         'name': _nameController.text.trim(),
//         'phone': _phoneController.text.trim(),
//         'isDefault': _isDefaultAddress,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       // Navigate to SavedAddressesPage after saving the address
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const SavedAddressesPage(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Color tealColor = Colors.teal;
//     final Color whiteColor = Colors.white;
//
//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         title: const Text("Add New Address"),
//         backgroundColor: tealColor,
//         elevation: 2,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Address",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _pincodeController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Pincode",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _houseController,
//               decoration: const InputDecoration(
//                 labelText: "House/Flat/Office No",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _roadController,
//               decoration: const InputDecoration(
//                 labelText: "Road Name/Area/Colony",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "Use as default address",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Switch(
//               value: _isDefaultAddress,
//               onChanged: (value) {
//                 setState(() {
//                   _isDefaultAddress = value;
//                 });
//               },
//               activeColor: tealColor,
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "Contact",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: "Name",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: "Phone Number",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _saveAddress,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: tealColor,
//                 minimumSize: const Size(double.infinity, 48),
//               ),
//               child: const Text("Save Address"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
