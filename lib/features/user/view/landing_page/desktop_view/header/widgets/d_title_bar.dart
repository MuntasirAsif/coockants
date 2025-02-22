import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/constants/color.dart';
import '../../../../../../../core/constants/image_string.dart';
import '../../../../../../../core/constants/text_string.dart';
import '../../../../../../../core/widgets/button_widgets.dart';
class DTitleBar extends StatelessWidget {
  const DTitleBar({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
  });

  final double deviceHeight;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: (){
              context.go('/');
            },
            child: Image.asset(logo,height: deviceHeight*0.15,width: deviceWidth*0.15,fit: BoxFit.fitWidth,)),
        SizedBox(
          width: deviceWidth*0.3,
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
        Row(
          children: [
            const Icon(Icons.notifications_none),
            const Gap(40),
            InkWell(
                onTap: (){
                  context.goNamed('login');
                },
                child: ButtonWidgets(name: login, color: loginButtonColor,)),
          ],
        )
      ],
    );
  }
}