import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAddressesPage extends StatefulWidget {
  final List<Map<String, String>> savedAddresses;
  final Function(Map<String, String>) onAddressAdded;

  MyAddressesPage({
    required this.savedAddresses,
    required this.onAddressAdded,
  });

  @override
  _MyAddressesPageState createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {
  void addNewAddress() {
    // Simulate adding a new address
    final newAddress = {
      'name': '',
      'address': '',
      'phone': '',
    };
    widget.onAddressAdded(newAddress);
    Navigator.pop(context, newAddress['address']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Addresses')),
      body: Column(
        children: [
          // Add new address button
          InkWell(
            onTap: addNewAddress,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Add a new address',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1),

          // Saved addresses list
          Expanded(
            child: ListView.builder(
              itemCount: widget.savedAddresses.length,
              itemBuilder: (context, index) {
                final address = widget.savedAddresses[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      address['name'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          address['address'] ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          address['phone'] ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context, address['address']);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}