// import 'package:flutter/material.dart';
//
// class AddressDetailsPage extends StatefulWidget {
//   const AddressDetailsPage({Key? key}) : super(key: key);
//
//   @override
//   _AddressDetailsPageState createState() => _AddressDetailsPageState();
// }
//
// class _AddressDetailsPageState extends State<AddressDetailsPage> {
//   // Initial values for the address fields
//   TextEditingController addressController = TextEditingController(text: '123 Main St, City, Country');
//   TextEditingController cityController = TextEditingController(text: 'City');
//   TextEditingController postalCodeController = TextEditingController(text: '12345');
//
//   bool isEditing = false; // Flag to toggle between edit and view mode
//
//   @override
//   Widget build(BuildContext context) {
//     final Color tealColor = Colors.teal;
//     final Color whiteColor = Colors.white;
//
//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         backgroundColor: tealColor,
//         title: const Text('Address Details'),
//         centerTitle: true,
//         elevation: 2,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Toggle Edit/View Mode
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Address Information',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     isEditing ? Icons.check : Icons.edit,
//                     color: tealColor,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isEditing = !isEditing;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Address input field
//             TextField(
//               controller: addressController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 labelText: 'Street Address',
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter your street address',
//                 labelStyle: TextStyle(color: tealColor),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: tealColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             // City input field
//             TextField(
//               controller: cityController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 labelText: 'City',
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter your city',
//                 labelStyle: TextStyle(color: tealColor),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: tealColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             // Postal Code input field
//             TextField(
//               controller: postalCodeController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 labelText: 'Postal Code',
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter your postal code',
//                 labelStyle: TextStyle(color: tealColor),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: tealColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             // Save or Add Address Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (isEditing) {
//                     // Save the address details
//                     String address = addressController.text;
//                     String city = cityController.text;
//                     String postalCode = postalCodeController.text;
//
//                     // Return the updated address to the ProfilePage
//                     Navigator.pop(context, '$address, $city, $postalCode');
//                   } else {
//                     // Navigate to the page to add the address
//                     String address = addressController.text;
//                     String city = cityController.text;
//                     String postalCode = postalCodeController.text;
//                     print('Address Added: $address, $city, $postalCode');
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: tealColor,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   isEditing ? 'Save Address' : 'Add Address',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
