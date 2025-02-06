import 'package:cookants/features/user/view/landing_page/mobile_view/header/widgets/m_header_body.dart';
import 'package:cookants/features/user/view/landing_page/mobile_view/header/widgets/m_title_bar.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/constants/color.dart';
import '../../../../../../core/constants/image_string.dart';

class MHeaderWidget extends StatelessWidget {
  const MHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
          decoration: BoxDecoration(
              color: headerBgColor,
          ),
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MTitleBar(deviceHeight: deviceHeight, deviceWidth: deviceWidth),
                  const MHeaderBody()
                ],
              ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            headerBodyImage,
            width: deviceWidth * 0.5,
          ),
        )
      ],
    );
  }
}
