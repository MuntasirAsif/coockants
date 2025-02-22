import 'dart:convert';
import 'package:cookants/data/APIs/api.dart';
import 'package:http/http.dart' as http;
import '../models/grocery_product_model.dart';

class GroceryProductRepository {
  // Fetch all products
  Future<List<GroceryProductModel>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(productApi));

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes); // ✅ UTF-8 Decoding
        List<dynamic> data = jsonDecode(decodedResponse);
        return data.map((json) => GroceryProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Fetch a product by ID
  Future<GroceryProductModel> getProductById(int productId) async {
    print('$productApi$productId/');
    final response = await http.get(Uri.parse('$productApi$productId/?format=json'));

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes); // ✅ UTF-8 Decoding
      return GroceryProductModel.fromJson(jsonDecode(decodedResponse));
    } else {
      throw Exception('Failed to load product');
    }
  }

  // Add a new product
  Future<void> addProduct(GroceryProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(productApi),
        headers: {'Content-Type': 'application/json; charset=UTF-8'}, // ✅ Ensure UTF-8 Encoding
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  // Update a product
  Future<void> updateProduct(int productId, GroceryProductModel product) async {
    print('Updating product...');
    try {
      print('$productApi$productId/');
      final response = await http.put(
        Uri.parse('$productApi$productId/'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'}, // ✅ Ensure UTF-8 Encoding
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // Delete a product
  Future<void> deleteProduct(int productId) async {
    try {
      final response = await http.delete(Uri.parse('$productApi$productId/'));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
