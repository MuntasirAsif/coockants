import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../constants/text_string.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool mobileView = screenWidth<700;
    double squareDimension = mobileView?screenWidth*0.4:screenWidth * 0.3;


    List<Widget> items = [
      _buildImageWithSquareShape('assets/images/reviews/1.jpg', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/2.png', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/3.png', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/4.jpg', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/5.jpg', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/6.png', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/7.jpg', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/8.jpg', squareDimension),
      _buildImageWithSquareShape('assets/images/reviews/9.jpg', squareDimension),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            reviewsTitle,
            style: TextStyle(fontSize: mobileView?14:28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          CarouselSlider(
            items: items, // Pass the items here
            options: CarouselOptions(
              height: squareDimension,
              aspectRatio: 1,
              viewportFraction: 0.3,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to wrap the image with a square shape
  Widget _buildImageWithSquareShape(String imagePath, double dimension) {
    return Container(
      width: dimension, // Width set to the square dimension
      height: dimension, // Height set to the same square dimension
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // Border color
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover, // Ensure image covers the container
        ),
      ),
    );
  }
}
