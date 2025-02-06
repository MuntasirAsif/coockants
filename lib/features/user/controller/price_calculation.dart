import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../data/models/order_item_model.dart';


class PriceCalculation extends GetxController {
  RxDouble totalPrice = 0.0.obs;
  RxList<OrderItem> selectedProducts = <OrderItem>[].obs;

  // Add or update a product
  void addProduct(String productId, String productName, double price, double quantity, String imageUrl) {
    final index = selectedProducts.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      // If the product already exists, update its quantity and other details
      final updatedProduct = selectedProducts[index].copyWith(
        quantity: quantity,
        imageUrl: imageUrl,
      );
      selectedProducts[index] = updatedProduct;

      // Remove the product if the quantity is 0
      if (quantity == 0) {
        selectedProducts.removeAt(index);
      }
    } else if (quantity > 0) {
      // If the product doesn't exist, add it to the list
      selectedProducts.add(OrderItem(
        productId: productId,
        productName: productName,
        price: price,
        quantity: quantity,
        imageUrl: imageUrl,
      ));
    }

    _recalculateTotalPrice();
  }

  // Remove a product by ID
  void removeProduct(String productId) {
    selectedProducts.removeWhere((item) => item.productId == productId);
    _recalculateTotalPrice();
  }

  // Update the quantity of an existing product
  void updateQuantity(String productId, double newQuantity) {
    final index = selectedProducts.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      final updatedProduct = selectedProducts[index].copyWith(quantity: newQuantity);
      selectedProducts[index] = updatedProduct;

      // Remove the product if the quantity is 0
      if (newQuantity == 0) {
        selectedProducts.removeAt(index);
      }
    }

    _recalculateTotalPrice();
  }

  // Clear all products
  void clearProducts() {
    selectedProducts.clear();
    totalPrice.value = 0;
  }

  // Private method to recalculate the total price
  void _recalculateTotalPrice() {
    totalPrice.value = selectedProducts.fold(0, (sum, item) => sum + item.totalPrice);
  }
}

