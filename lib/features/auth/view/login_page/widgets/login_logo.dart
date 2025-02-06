import 'package:flutter/material.dart';
import '../../../../../core/constants/image_string.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(width:deviceWidth*0.5,child: Image.asset(logo));
  }
}
