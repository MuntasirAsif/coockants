import 'package:cookants/features/user/view/landing_page/desktop_view/header/d_header_widget.dart';
import 'package:cookants/features/user/view/landing_page/landing_page_body.dart';
import 'package:cookants/features/user/view/landing_page/mobile_view/header/m_header_Widget.dart';
import 'package:flutter/material.dart';
import 'package:seo/html/seo_widget.dart';

import '../../../../core/constants/text_string.dart';
import 'desktop_view/footer/d_footer_widgets.dart';
import 'mobile_view/footer/m_footer_widgets.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Seo.text(
      text: '$titlePart1 $subtitle $freshFishes $freshMeats $fruitsAndPickles',
      child: Scaffold(
        body: LayoutBuilder(builder: (context,constraints){
          if(constraints.maxWidth>750){
            return desktopView();
          }else{
            return mobileView();
          }
        }),
      ),
    );
  }
}

Widget mobileView() {
  return const SingleChildScrollView(
    child: Column(
      children: [
        MHeaderWidget(),
        LandingPageBody(),
        MFooterWidgets()
      ],
    ),
  );
}

Widget desktopView() {
  return const SingleChildScrollView(
    child: Column(
      children: [
        DHeaderWidget(),
        LandingPageBody(),
        DFooterWidgets()
      ],
    ),
  );
}
