import 'package:cookants/core/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../constants/color.dart';

class CharacteristicWidgets extends StatelessWidget {
  final String title;
  final String categoryName;
  final List<String> list;
  final String image;
  final bool isLeft;
  const CharacteristicWidgets({super.key, required this.title, required this.list, required this.image, required this.isLeft, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// **Title with Custom Background**
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: orderButtonColor,
              ),
            ),
          ),
          const SizedBox(height: 15),

          /// **Image and List Column**
          isLeft?Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Image with Rounded Corners & Shadow**
              CharacteristicImageWidgets(deviceWidth: deviceWidth, image: image),
              const SizedBox(width: 15),

              /// **List Displayed as Column**
              CharascteristicBody(list: list, categoryName: categoryName,),
            ],
          ):Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **List Displayed as Column**
              CharascteristicBody(list: list, categoryName: categoryName,),
              const SizedBox(width: 15),
              /// **Image with Rounded Corners & Shadow**
              CharacteristicImageWidgets(deviceWidth: deviceWidth, image: image),
            ],
          ),
        ],
      ),
    );
  }
}

class CharascteristicBody extends StatelessWidget {
  final String categoryName;
  const CharascteristicBody({
    super.key,
    required this.list, required this.categoryName,
  });

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list.map((itemText) {
              List<String> parts = itemText.split(':');
              String beforeColon = parts[0];
              String afterColon = parts.length > 1 ? parts[1] : '';

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: loginButtonColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$beforeColon: ',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: afterColon,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const Gap(10),
          InkWell(
            onTap: (){
              context.go('/order/${categoryName}');
            },
            child: SizedBox(
              width: 200,
                height: 70,
                child: ButtonWidgets(name: 'অর্ডার করুন', color: orderButtonColor)),
          )
        ],
      ),
    );
  }
}

class CharacteristicImageWidgets extends StatelessWidget {
  const CharacteristicImageWidgets({
    super.key,
    required this.deviceWidth,
    required this.image,
  });

  final double deviceWidth;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.4,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
