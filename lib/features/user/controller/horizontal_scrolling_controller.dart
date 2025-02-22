import 'package:flutter/material.dart';

class HorizontalScrollController {
  final ScrollController scrollController = ScrollController();

  void scrollLeft() {
    if (scrollController.hasClients && scrollController.positions.isNotEmpty) {
      final double currentPosition = scrollController.position.pixels;
      final double targetPosition = currentPosition - 250; // Adjust scroll amount as needed

      scrollController.animateTo(
        targetPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollRight() {
    if (scrollController.hasClients && scrollController.positions.isNotEmpty) {
      final double currentPosition = scrollController.position.pixels;
      final double targetPosition = currentPosition + 250; // Adjust scroll amount as needed

      scrollController.animateTo(
        targetPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}