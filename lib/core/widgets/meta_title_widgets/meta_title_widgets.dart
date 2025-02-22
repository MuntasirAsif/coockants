import 'package:flutter/material.dart';
import '../../constants/color.dart';
import '../../constants/text_string.dart';

class MetaTitleWidget extends StatelessWidget {
  const MetaTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: orderButtonColor),
          borderRadius:BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 32),
          child: Center(
            child: Center(
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: metaTitlePart1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: metaTitlePart2,
                      style: TextStyle(
                        color: productNameTextColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: metaTitlePart1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            )
            ,
          )

        )));
  }
}
