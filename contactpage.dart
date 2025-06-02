import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Contact Us"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/city_bg.jpg"), // Replace with your background image
                  fit: BoxFit.cover,
                ),
              ),
              child: constraints.maxWidth > 700
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactInfo(),
                  SizedBox(width: 50),
                  Expanded(child: _buildContactForm(context)),
                ],
              )
                  : Column(
                children: [
                  _buildContactInfo(),
                  SizedBox(height: 30),
                  _buildContactForm(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Us",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
              "Reiciendis dignissimos eaque doloremque, nulla mollitia facilis.",
          style: TextStyle(color: Colors.white70),
        ),
        SizedBox(height: 30),
        _contactItem(Icons.location_on, "Address",
            "4671 Sugar Camp Road,\nOwatonna, Minnesota,\n55060"),
        SizedBox(height: 20),
        _contactItem(Icons.phone, "Phone", "561-456-2321"),
        SizedBox(height: 20),
        _contactItem(Icons.email, "Email", "example@email.com"),
      ],
    );
  }

  Widget _contactItem(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(content, style: TextStyle(color: Colors.white70)),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Send Message", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: "Full Name"),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 15),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(labelText: "Type your Message..."),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    // Add message sending logic
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Message sent (not really, just a placeholder)"),
                    ));
                  },
                  child: Text("Send"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
