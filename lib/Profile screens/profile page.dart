import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../survice/Save addres page.dart';
import 'edit profile page.dart';

import '../EPMT PAGES/User Order page.dart';
import '../EPMT PAGES/whishlist page.dart';
import 'select language page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        username = doc['name'] ?? 'Guest';
        email = user.email ?? 'No Email';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color tealColor = Colors.teal;
    final Color whiteColor = Colors.white;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: tealColor,
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.person, color: whiteColor),
                const SizedBox(width: 8),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info Section
            Container(
              color: tealColor.withOpacity(0.1),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: tealColor,
                    child: Icon(Icons.person, size: 40, color: whiteColor),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final updatedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(),
                            ),
                          );

                          if (updatedName != null) {
                            setState(() {
                              username = updatedName;
                            });
                          }
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            // Quick Actions Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSmallButton(
                    label: "Orders",
                    icon: Icons.shopping_bag,
                    color: tealColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserOrdersPage()),
                      );
                    },
                  ),
                  _buildSmallButton(
                    label: "Wishlist",
                    icon: Icons.favorite_border,
                    color: tealColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WishlistPage()),
                      );
                    },
                  ),
                  _buildSmallButton(
                    label: "Coupons",
                    icon: Icons.card_giftcard,
                    color: tealColor,
                    onTap: () {
                      // Navigate to Coupons Page
                    },
                  ),
                  _buildSmallButton(
                    label: "Help",
                    icon: Icons.headset_mic,
                    color: tealColor,
                    onTap: () {
                      // Navigate to Help Center Page
                    },
                  ),
                ],
              ),
            ),
            const Divider(),

            // Account Settings Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Account Settings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.person_outline,
              title: "Edit Profile",
              onTap: () async {
                final updatedName = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );

                if (updatedName != null) {
                  setState(() {
                    username = updatedName;
                  });
                }
              },
            ),
            _buildListTile(
              icon: Icons.credit_card,
              title: "Saved Credit / Debit & Gift Cards",
              onTap: () {
                // Navigate to Payment Methods Page
              },
            ),
            _buildListTile(
              icon: Icons.location_on_outlined,
              title: "Saved Addresses",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedAddressesPage()));
              },
            ),
            _buildListTile(
              icon: Icons.language,
              title: "Select Language",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSelectionPage(
                      onLanguageChanged: (String languageCode) {},
                    ),
                  ),
                );
              },
            ),
            _buildListTile(
              icon: Icons.notifications_none,
              title: "Notification Settings",
              onTap: () {
                // Navigate to Notification Settings Page
              },
            ),
            const Divider(),

            // My Activity Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "My Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.reviews,
              title: "Reviews",
              onTap: () {
                // Navigate to Reviews Page
              },
            ),
            _buildListTile(
              icon: Icons.question_answer_outlined,
              title: "Questions & Answers",
              onTap: () {
                // Navigate to Q&A Page
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildSmallButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.1),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
