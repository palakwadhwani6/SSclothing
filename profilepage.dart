import 'package:flutter/material.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User info section
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("johndoe@example.com",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 10),

            // Quick Access Tiles
            _buildQuickTile(Icons.shopping_bag, "Orders", context),
            _buildQuickTile(Icons.favorite_border, "Wishlist", context),
            _buildQuickTile(Icons.card_giftcard, "Coupons", context),
            _buildQuickTile(Icons.location_on_outlined, "Saved Addresses", context),

            SizedBox(height: 10),

            // Account Settings
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildSettingsTile(Icons.account_circle_outlined, "Account Settings"),
                  _buildSettingsTile(Icons.lock_outline, "Change Password"),
                  _buildSettingsTile(Icons.notifications_outlined, "Notification Settings"),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Help & Support
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildSettingsTile(Icons.help_outline, "Help Center"),
                  _buildSettingsTile(Icons.support_agent, "Contact Support"),
                  _buildSettingsTile(Icons.info_outline, "About"),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Logout Button
            TextButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
    (route) => false,
    );
              },
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text("LOG OUT", style: TextStyle(color: Colors.red)),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTile(IconData icon, String title, BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 1),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          // Navigate or handle tap
        },
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(title),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // Navigate or handle tap
          },
        ),
        Divider(height: 0),
      ],
    );
  }
}
