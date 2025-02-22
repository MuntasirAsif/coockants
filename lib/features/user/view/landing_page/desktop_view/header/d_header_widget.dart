import 'package:cookants/core/constants/color.dart';
import 'package:cookants/core/constants/image_string.dart';
import 'package:cookants/core/widgets/product_card/header_category_card.dart';
import 'package:cookants/features/user/view/landing_page/desktop_view/header/widgets/d_header_body.dart';
import 'package:cookants/features/user/view/landing_page/desktop_view/header/widgets/d_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../../core/constants/text_string.dart';

class DHeaderWidget extends StatelessWidget {
  const DHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 650,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: deviceHeight,
              child: Image.asset(
                headerBodyImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.03),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
            ),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DTitleBar(deviceHeight: deviceHeight, deviceWidth: deviceWidth),
                const DHeaderBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


