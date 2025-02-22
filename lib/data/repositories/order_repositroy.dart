import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderRepository {
  final String baseUrl = 'https://api.cookantsfresh.com/orders/';

  // Fetch All Orders
  Future<List<Order>> getAllOrders() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        // Ensure Bangla text is decoded properly
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((order) => Order.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Create Order with Bangla Support
  Future<Order> createOrder(Order order, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'}, // UTF-8 support
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('আপনার অর্ডার সফলভাবে সম্পন্ন হয়েছে'),
            backgroundColor: Colors.green,
          ),
        );

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('সফল'),
              content: const Text('আপনার অর্ডার সফলভাবে সম্পন্ন হয়েছে'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/');
                  }, // Close dialog
                  child: const Text('ঠিক আছে'),
                ),
              ],
            );
          },
        );
        return Order.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sorry Error Something...'),
            backgroundColor: Colors.red,
          ),
        );
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print(e);
      throw Exception('Error: $e');
    }
  }

  // Update Order
  Future<void> updateOrder(int id, Order order) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$id/'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update order');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Delete Order
  Future<void> deleteOrder(int id,BuildContext context) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$id/'));
      if (response.statusCode != 204) {
        throw Exception('Failed to delete order');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Deleted'),
              backgroundColor: Colors.black,
            ));
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
