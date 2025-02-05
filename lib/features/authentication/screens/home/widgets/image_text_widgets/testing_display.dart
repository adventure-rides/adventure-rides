import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TestingDisplay extends StatelessWidget {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  final List<Map<String, String>> slides = [
    {
      "image": "assets/images/banners/banner_img_1.png",
      "title": "HIRE ON A DAILY, WEEKLY OR MONTHLY BASIS.",
      "buttonText": "BOOK A VEHICLE"
    },
    {
      "image": "assets/images/banners/banner_img_2.png",
      "title": "FIND THE PERFECT CAR FOR YOUR JOURNEY.",
      "buttonText": "EXPLORE VEHICLES"
    },
    {
      "image": "assets/images/banners/banner_img_3.png",
      "title": "DRIVE WITH COMFORT AND SAFETY.",
      "buttonText": "GET STARTED"
    },
  ];

  TestingDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                _currentIndex.value = index;
              },
            ),
            items: slides.map((slide) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    slide["image"]!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          slide["title"]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          child: Text(
                            slide["buttonText"]!,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }).toList(),
          ),

          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, index, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: slides.asMap().entries.map((entry) {
                    return Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == entry.key ? Colors.white : Colors.grey,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}