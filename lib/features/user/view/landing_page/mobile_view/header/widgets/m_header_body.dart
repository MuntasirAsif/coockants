import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../core/constants/image_string.dart';
import '../../../../../../../core/constants/text_string.dart';
import '../../../../../../../core/widgets/product_card/header_category_card.dart';
class MHeaderBody extends StatelessWidget {
  const MHeaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(30),
        SelectableText(
          titlePart1,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SelectableText(
          subtitle,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Gap(5),
        HeaderCategoryCard(
            categoryName: 'সতেজ মুদিপন্য', storeNumber: '২০', image: category1),
        HeaderCategoryCard(
            categoryName: 'সতেজ মুদিপন্য', storeNumber: '১৬', image: category2),
        HeaderCategoryCard(
            categoryName: 'সতেজ মুদিপন্য', storeNumber: '১০', image: category3),
        Gap(40),
      ],
    );
  }
}
