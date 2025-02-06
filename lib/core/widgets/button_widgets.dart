import 'package:flutter/material.dart';

class ButtonWidgets extends StatelessWidget {
  final String name;
  final Color color;
  const ButtonWidgets({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(child: Text(name,style: const TextStyle(color: Colors.white),)),
    );
  }
}
