import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:first_project/contactpage.dart';
import 'package:first_project/salepage.dart';
import 'package:first_project/cart_page.dart';
import 'package:first_project/profilepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.black,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                "ONE LIFE ONE CHOICE",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            AppBar(
              backgroundColor: Colors.white,
              elevation: 2,
              centerTitle: false,
              titleSpacing: 0,
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'SS Clothing',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Spacer(),
                  NavItem(
                    'CONTACT',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ContactPage()));
                    },
                  ),
                  NavItem(
                    'SALE',
                    isHighlighted: true,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SalePage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CartPage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.black),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProfilePage()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: 20),
              AutoScrollingImageWindow(
                imagePaths: [
                  'assets/photos/1.jpg',
                  'assets/photos/2.jpg',
                  'assets/photos/3.jpg',
                ],
                height: screenWidth * 0.6, // responsive height
                width: double.infinity,
              ),
              SizedBox(height: 20),
              Text(
                "Explore our latest collection!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(6, (index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/photos/${index + 1}.jpg',
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
                }),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: FaIcon(FontAwesomeIcons.whatsapp),
        onPressed: () async {
          final phoneNumber = '8819961023'; // add country code here (e.g. 88)
          final whatsappUrl = Uri.parse("whatsapp://send?phone=$phoneNumber");

          if (await canLaunchUrl(whatsappUrl)) {
            await launchUrl(whatsappUrl);
          } else {
            // Fallback to WhatsApp web if app not installed
            final whatsappWebUrl = Uri.parse("https://wa.me/$phoneNumber");
            if (await canLaunchUrl(whatsappWebUrl)) {
              await launchUrl(whatsappWebUrl, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Could not open WhatsApp")),
              );
            }
          }
        },
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      splashColor: Colors.redAccent.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            color: isHighlighted ? Colors.redAccent : Colors.black87,
            fontWeight: FontWeight.w600,
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
  final double width;

  const AutoScrollingImageWindow({
    Key? key,
    required this.imagePaths,
    this.scrollInterval = const Duration(seconds: 5),
    this.height = 250.0,
    this.width = double.infinity,
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

      _currentPage = (_currentPage + 1) % widget.imagePaths.length;
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
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imagePaths.length,
          itemBuilder: (context, index) {
            return Image.asset(
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
            );
          },
        ),
      ),
    );
  }
}
