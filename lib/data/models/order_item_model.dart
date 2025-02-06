class OrderItem {
  final String productId;
  final String productName;
  final String imageUrl;
  final double price;
  final double quantity;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  // Convert from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      imageUrl: json['image_url'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: double.tryParse(json['quantity'].toString()) ?? 0.0,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'image_url': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  // Calculate the total price for this item
  double get totalPrice => price * quantity;

  // Create a copy of the object with modified fields
  OrderItem copyWith({
    String? productId,
    String? productName,
    String? imageUrl,
    double? price,
    double? quantity,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  // Override the toString method to print the OrderItem more clearly
  @override
  String toString() {
    return 'OrderItem(productId: $productId, productName: $productName, imageUrl: $imageUrl, price: $price, quantity: $quantity, totalPrice: $totalPrice)';
  }
}
