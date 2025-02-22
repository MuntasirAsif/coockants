import 'package:cookants/core/constants/color.dart';
import 'package:cookants/features/user/view/landing_page/desktop_view/header/widgets/d_title_bar.dart';
import 'package:cookants/features/user/view/order_page/widgets/order_page_body.dart';
import 'package:flutter/material.dart';
import 'package:seo/head_tag.dart';
import 'package:seo/html/seo_widget.dart';
import '../landing_page/desktop_view/footer/d_footer_widgets.dart';
import '../landing_page/mobile_view/footer/m_footer_widgets.dart';
import '../landing_page/mobile_view/header/widgets/m_title_bar.dart';

class OrderPage extends StatefulWidget {
  final String category;
  const OrderPage({super.key, required this.category, });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  Widget build(BuildContext context) {

    return Seo.head(
      tags: [
        MetaTag(name: 'Cookants - ${widget.category} Orders', content: 'View and manage orders for the ${widget.category} category.'),
        LinkTag(rel: widget.category, href: 'https://www.cookantsfresh.com/order/${widget.category}'),
      ],
      child: Scaffold(
        body: LayoutBuilder(builder: (context,constraints){
          if(constraints.maxWidth>750){
            return desktopView(context);
          }else{
            return mobileView(context);
          }
        }),
      ),
    );
  }

Widget mobileView(BuildContext context) {
  late double deviceWidth;
  late double deviceHeight;
  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height;
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
            color: headerBgColor,
            padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.03,vertical: 5),
            child: MTitleBar(deviceHeight: deviceHeight, deviceWidth: deviceWidth)),
        OrderPageBody(category: widget.category,),
        const MFooterWidgets()
      ],
    ),
  );
}

Widget desktopView(BuildContext context) {
  late double deviceWidth;
  late double deviceHeight;
  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height;
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          color: headerBgColor,
            padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.03),
            child: DTitleBar(deviceHeight: deviceHeight, deviceWidth: deviceWidth)),
        OrderPageBody(category: widget.category,),
        const DFooterWidgets()
      ],
    ),
  );
}
}