import 'dart:async';
import 'package:flutter/material.dart';
import 'package:first_project/contactpage.dart';
import 'package:first_project/salepage.dart';
import 'package:first_project/cart_page.dart';
import 'package:first_project/profilepage.dart';

void main() {
  runApp(SSClothingApp());
}

class SSClothingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SS Clothing',
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                "ONE LIFE ONE CHOICE",
                style: TextStyle(color: Colors.white),
              ),
            ),
            AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Row(
                children: [
                  Text(
                    'SS Clothing',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Spacer(),
                  NavItem(
                    'CONTACT',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ContactPage()));
                    },
                  ),
                  NavItem(
                    'SALE',
                    isHighlighted: true,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SalePage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.black),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            AutoScrollingImageWindow(
              imagePaths: [
                'assets/images/1.jpg',
                'assets/images/2.jpg',
                'assets/images/3.jpg',
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Explore our latest collection!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(6, (index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/${index + 1}.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const NavItem(
      this.title, {
        this.isHighlighted = false,
        this.onTap,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          title,
          style: TextStyle(
            color: isHighlighted ? Colors.redAccent : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class AutoScrollingImageWindow extends StatefulWidget {
  final List<String> imagePaths;
  final Duration scrollInterval;
  final double height;

  const AutoScrollingImageWindow({
    Key? key,
    required this.imagePaths,
    this.scrollInterval = const Duration(seconds: 5),
    this.height = 250.0,
  }) : super(key: key);

  @override
  _AutoScrollingImageWindowState createState() =>
      _AutoScrollingImageWindowState();
}

class _AutoScrollingImageWindowState extends State<AutoScrollingImageWindow> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    if (widget.imagePaths.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.scrollInterval, (timer) {
      if (!mounted) return;

      setState(() {
        _currentPage = (_currentPage + 1) % widget.imagePaths.length;
      });

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.imagePaths[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.broken_image, size: 40),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
