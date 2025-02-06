import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/constants/color.dart';
import '../../../../../../../core/constants/image_string.dart';
import '../../../../../../../core/constants/text_string.dart';
import '../../../../../../../core/widgets/button_widgets.dart';
class MTitleBar extends StatelessWidget {
  const MTitleBar({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
  });

  final double deviceHeight;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(logo,height: deviceHeight*0.1,width: deviceWidth*0.4,fit: BoxFit.fitWidth,),
            Row(
              children: [
                const Icon(Icons.notifications_none),
                const Gap(30),
                InkWell(
                    onTap: (){
                      context.goNamed('login');
                    },
                    child: ButtonWidgets(name: login, color: loginButtonColor,)),
              ],
            )
          ],
        ),
        SizedBox(
          width: deviceWidth,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: search,
              filled: true,
              fillColor: Colors.white,
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}