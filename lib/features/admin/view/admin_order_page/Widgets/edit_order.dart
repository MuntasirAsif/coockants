import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/controller/order_controller.dart';
import '../../../../../data/models/order_item_model.dart';
import '../../../../../data/models/order_model.dart';

class EditOrderPage extends StatelessWidget {
  final Order order;
  final OrderController orderController = Get.put(OrderController()); // Initialize here

  EditOrderPage({Key? key, required this.order}) : super(key: key);

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<String> orderStatuses = [
    'Pending',
    'Confirmed',
    'Delivered',
    'Canceled'
  ];

  @override
  Widget build(BuildContext context) {
    int? orderId = order.orderId;
    customerNameController.text = order.customerName;
    addressController.text = order.address;
    phoneController.text = order.customerPhoneNumber;

    // Ensure that the selectedStatus is valid and avoid duplicates
    String selectedStatus = order.orderStatus;
    if (!orderStatuses.contains(selectedStatus)) {
      selectedStatus = orderStatuses[0]; // Default to 'Pending' if invalid status
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: customerNameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              items: orderStatuses.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) selectedStatus = value;
              },
              decoration: const InputDecoration(
                labelText: 'Order Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // List of Order Items
            const Text('Order Items:'),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return ListTile(
                    title: Text(item.productName),
                    subtitle: Text('Price: ${item.price} x ${item.quantity}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        // Show a dialog or navigate to another page to edit the item
                        await _editItemDialog(context, item, index);
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Order updatedOrder = Order(
                    orderId: order.orderId,
                    customerName: customerNameController.text,
                    address: addressController.text,
                    customerPhoneNumber: phoneController.text,
                    orderStatus: selectedStatus,
                    paymentMethod: order.paymentMethod,
                    deliveryLocation: order.deliveryLocation,
                    deliveryCharge: order.deliveryCharge,
                    items: order.items,
                  );
                  print(orderId);
                  print(updatedOrder.orderId);
                  print(updatedOrder.address);
                  print(updatedOrder.items);
                  print(updatedOrder.deliveryCharge);
                  print(updatedOrder.customerName);
                  print(updatedOrder.customerPhoneNumber);
                  print(updatedOrder.orderStatus);
                  print(updatedOrder.paymentMethod);
                  print(updatedOrder.deliveryLocation);

                  orderController.updateOrder(orderId!, updatedOrder);
                  Navigator.pop(context);
                },
                child: const Text('Update Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog to edit order item details
  Future<void> _editItemDialog(
      BuildContext context, OrderItem item, int index) async {
    final TextEditingController priceController =
    TextEditingController(text: item.price.toString());
    final TextEditingController quantityController =
    TextEditingController(text: item.quantity.toString());

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Order Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final updatedItem = item.copyWith(
                  price: double.tryParse(priceController.text) ?? item.price,
                  quantity:
                  double.tryParse(quantityController.text) ?? item.quantity,
                );
                order.items[index] = updatedItem; // Update the item
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
