import 'package:cookants/core/constants/image_string.dart';
import 'package:flutter/material.dart';

class HeaderCategoryCard extends StatelessWidget {
  final String categoryName;
  final String storeNumber;
  final String image;

  const HeaderCategoryCard({super.key, required this.categoryName, required this.storeNumber, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 80,
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoryName,style: const TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                Text('$storeNumber টির বেশি দোকান',style: const TextStyle(fontSize: 12),),
              ],
            ),
          ),
          Image.asset(image),
        ],
      ),
    );
  }
}
