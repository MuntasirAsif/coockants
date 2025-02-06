
import 'package:flutter/material.dart';

import '../../../../../../core/constants/image_string.dart';

class MFooterWidgets extends StatefulWidget {
  const MFooterWidgets({super.key});

  @override
  State<MFooterWidgets> createState() => _MFooterWidgetsState();
}

class _MFooterWidgetsState extends State<MFooterWidgets> {
  late double deviceWidth;
  late double deviceHeight;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xFFF4E6E6),
      padding: const EdgeInsets.all(16.0),
      child: _buildMobileFooter(),
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoAndDescription(),
        const SizedBox(height: 16),
        _buildSocialIcons(),
        const SizedBox(height: 16),
        _buildFooterLinks(),
      ],
    );
  }

  // Logo and Description Section
  Widget _buildLogoAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(logoFooter,height: deviceHeight*0.15,width: deviceWidth*0.40,fit: BoxFit.fitWidth,),
        const SizedBox(height: 8),
        const Text(
          "আপনার জন্য তৈরি ব্যক্তিগত খাবারের এক গন্তব্য। খাবারের ভাল দিক থেকে এক ঝলক সুবিধা।",
          style: TextStyle(fontSize: 14, color: Color(0xFF293A54)),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Social Media Icons Section
  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildSocialIcon(facebook),
        _buildSocialIcon(linkedin),
        _buildSocialIcon(twitter),
        _buildSocialIcon(instagram),
      ],
    );
  }

  Widget _buildSocialIcon(String image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(image),
    );
  }

  // Footer Links Section
  Widget _buildFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLinkSection("আমাদের সাথে পরিচিত হন", [
          "সম্পর্কে",
          "ক্লাব",
          "আমাদের মূল্য",
          "যোগাযোগ",
          "সহায়তা কেন্দ্র"
        ]),
        const SizedBox(height: 16),
        _buildLinkSection("গ্রাহকদের জন্য", [
          "পেমেন্ট",
          "শিপিং",
          "পথ ফেড",
          "প্রাথমিক ডিজাইড প্রমাণালী",
          "দোকান চেকআউট"
        ]),
        const SizedBox(height: 16),
        _buildLinkSection("সাহায্য", [
          "সহজ সহায়তা",
          "অর্ডার ফেড",
          "অর্ডার ট্র্যাক",
          "প্রতিক্রিয়া",
          "নিরাপত্তা এবং জানিসূচি"
        ]),
      ],
    );
  }

  Widget _buildLinkSection(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF293A54),
          ),
        ),
        const SizedBox(height: 8),
        for (var link in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              link,
              style: const TextStyle(fontSize: 14, color: Color(0xFF4F6F8F)),
            ),
          ),
      ],
    );
  }
}
