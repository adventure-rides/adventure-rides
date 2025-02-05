import 'package:flutter/material.dart';
import 'dart:async';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> slides = [
    {
      "image": "assets/images/cars/slide1.jpg",
      "title": "FIND THE PERFECT \nCAR FOR YOUR JOURNEY.",
      "buttonText": "EXPLORE VEHICLES",
      "textAlign": Alignment.centerLeft,
      "buttonColor": Colors.blue,
    },
    {
      "image": "assets/images/cars/slide2.jpg",
      "title": "CHAUFFEUR-DRIVEN \nVEHICLES INSTANTLY.",
      "buttonText": "BOOK A VEHICLE",
      "textAlign": Alignment.centerLeft,
      "buttonColor": Colors.blue,
    },
    {
      "image": "assets/images/cars/slide3.jpg",
      "title": "HIRE OUR SELF-DRIVE,\nOR CHAUFFEUR-DRIVEN \nVEHICLES INSTANTLY.",
      "buttonText": "BOOK A VEHICLE",
      "textAlign": Alignment.centerLeft,
      "buttonColor": Colors.blue,
    },
  ];


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % slides.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fading Carousel - 75% of screen height
            SizedBox(
              //height: screenHeight * 0.75,
              height: 400,
              child: Stack(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(seconds: 2),
                    child: Container(
                      key: ValueKey<int>(_currentIndex),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(slides[_currentIndex]["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Dark Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),

                  // Text & Button
                  Positioned(
                    left: 20,
                    bottom: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          slides[_currentIndex]["title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: slides[_currentIndex]["buttonColor"],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                          ),
                          child: Text(
                            slides[_currentIndex]["buttonText"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40), // Added spacing

          ],
        ),
      ),
    );
  }
}