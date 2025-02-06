import 'package:flutter/cupertino.dart';

class HorizontalScrollController {
  final ScrollController scrollController = ScrollController();

  void scrollLeft() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.offset - 200, // Adjust scroll amount as needed
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollRight() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.offset + 200, // Adjust scroll amount as needed
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}
