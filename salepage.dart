import 'package:flutter/material.dart';

void main() => runApp(SalePageApp());

class SalePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SalePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SalePage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Wireless Earbuds, IPX8",
      "price": "\$29.99",
      "image": "assets/earbuds.png",
    },
    {
      "name": "AirPods Max",
      "price": "\$549.00",
      "image": "assets/airpods_max.png",
    },
    {
      "name": "Bose BT Earphones",
      "price": "\$199.99",
      "image": "assets/bose_bt.png",
    },
    {
      "name": "WH-1000X Headphones",
      "price": "\$249.99",
      "image": "assets/sony_wh.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopcart'),
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Container(
              color: Colors.green[50],
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Grab Up to 50% Off On",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Selected Headphone",
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Buy Now"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.asset("assets/banner_headphones.png"),
                  ),
                ],
              ),
            ),
            // Category Filters
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Wrap(
                spacing: 10,
                children: [
                  Chip(label: Text("Headphone Type")),
                  Chip(label: Text("Wired")),
                  Chip(label: Text("Bluetooth")),
                  Chip(label: Text("Over-Ear")),
                ],
              ),
            ),
            // Product Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.75),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(product['image'], height: 100),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product['name'],
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(product['price'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800])),
                        SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Add to Cart"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600]),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
