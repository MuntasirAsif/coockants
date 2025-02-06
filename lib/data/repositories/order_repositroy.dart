import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/order_model.dart';

class OrderRepository {
  final String baseUrl = 'http://127.0.0.1:8000/orders/';

  Future<List<Order>> getAllOrders() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((order) => Order.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Order> createOrder(Order order) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Your order has placed successfully');
        return Order.fromJson(jsonDecode(response.body));
      } else {
        print('Error: ${response.body}');
        throw Exception('Failed to create order');
      }

    } catch (e) {
      print(e);
      throw Exception('Error: $e');
    }
  }

  Future<void> updateOrder(int id, Order order) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update order');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteOrder(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$id/'));
      if (response.statusCode != 204) {
        throw Exception('Failed to delete order');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}