class GroceryProductModel {
  final int productId;
  final String productName;
  final String? productDescription;
  final String productImage;
  final double productCurrentPrice;
  final double? productOriginalPrice;
  final String productCategory;
  final String productUnit;

  GroceryProductModel({
    required this.productId,
    required this.productName,
    this.productDescription,
    required this.productImage,
    required this.productCurrentPrice,
    this.productOriginalPrice,
    required this.productCategory,
    required this.productUnit,
  });

  factory GroceryProductModel.fromJson(Map<String, dynamic> json) {
    print("API Response: $json");
    return GroceryProductModel(
      productId: json['id'] ?? 0,
      productName: json['product_name'] ?? 'Unknown',
      productDescription: json['product_description'] as String? ?? '',
      productImage: json['product_image'] as String? ?? '',
      productCurrentPrice: _toDouble(json['product_current_price']),
      productOriginalPrice: _toDouble(json['product_original_price']),
      productCategory: json['product_category'] ?? 'Uncategorized',
      productUnit: json['product_unit'] ?? 'Unit',
    );
  }


  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsedValue = double.tryParse(value);
      return parsedValue ?? 0.0;
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'product_name': productName,
      'product_description': productDescription,
      'product_image': productImage,
      'product_current_price': productCurrentPrice,
      'product_original_price': productOriginalPrice,
      'product_category': productCategory,
      'product_unit': productUnit,
    };
  }
}
