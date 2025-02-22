import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../../../core/constants/color.dart';
import '../../../../../../../core/constants/image_string.dart';
import '../../../../../../../core/constants/text_string.dart';
import '../../../../../../../core/widgets/product_card/header_category_card.dart';
class DHeaderBody extends StatelessWidget {
  const DHeaderBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(250),
        Row(
          children: [
            SelectableText(
              titlePart1,
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold,color: orderButtonColor),
            ),
            SelectableText(
              titlePart2,
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold,color: productNameTextColor),
            ),
          ],
        ),
        SelectableText(
          subtitle,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Gap(5),
       /* HeaderCategoryCard(
            categoryName: 'সতেজ মুদিপন্য', storeNumber: '২০', image: category1),
        HeaderCategoryCard(
            categoryName: 'সতেজ মুদিপন্য', storeNumber: '১৬', image: category2),
        HeaderCategoryCard(
            categoryName: 'সতেজ মুদিপন্য', storeNumber: '১০', image: category3),*/
        Gap(40),
      ],
    );
  }
}
