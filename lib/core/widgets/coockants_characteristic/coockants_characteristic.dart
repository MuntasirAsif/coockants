import 'package:flutter/material.dart';
import '../../constants/color.dart';

class CoockantsCharacteristic extends StatelessWidget {
  final List<String> list;
  final String title;

  const CoockantsCharacteristic({
    super.key,
    required this.list,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// **Title with Stylish Background**
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          decoration: BoxDecoration(
            color: headerBgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: orderButtonColor,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),

        /// **List Displayed as Column**
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: list.map((itemText) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  /// **Check Icon**
                  Icon(
                    Icons.check_circle_rounded,
                    color: loginButtonColor,
                    size: 24,
                  ),
                  const SizedBox(width: 10),

                  /// **Text**
                  Expanded(
                    child: Text(
                      itemText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
