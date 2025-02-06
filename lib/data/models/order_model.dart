import 'order_item_model.dart';

class Order {
  final int? orderId;
  final String customerName;
  final String customerPhoneNumber;
  final String address;
  final String paymentMethod;
  final String? transactionId; // Nullable
  final String? transactionPhoneNumber; // Nullable
  final String deliveryLocation;
  final double deliveryCharge;
  final List<OrderItem> items;
  final String orderStatus;

  Order({
    this.orderId,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.address,
    required this.paymentMethod,
    this.transactionId, // Nullable
    this.transactionPhoneNumber, // Nullable
    required this.deliveryLocation,
    required this.deliveryCharge,
    required this.items,
    required this.orderStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsList = (json['items'] as List?)
        ?.map((item) => OrderItem.fromJson(item))
        .toList() ?? [];

    return Order(
      orderId: json['id'],
      customerName: json['customer_name'] ?? '', // Default to empty string if null
      customerPhoneNumber: json['customer_phone_number'] ?? '', // Default to empty string if null
      address: json['address'] ?? '', // Default to empty string if null
      paymentMethod: json['payment_method'] ?? '', // Default to empty string if null
      transactionId: json['transaction_id'], // Nullable, no default needed
      transactionPhoneNumber: json['transaction_phone_number'], // Nullable, no default needed
      deliveryLocation: json['delivery_location'] ?? '', // Default to empty string if null
      deliveryCharge: double.tryParse(json['delivery_charge'].toString()) ?? 0.0, // Ensure it's   a valid double
      items: itemsList,
      orderStatus: json['order_status'] ?? '', // Default to empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': orderId,
      'customer_name': customerName,
      'customer_phone_number': customerPhoneNumber,
      'address': address,
      'payment_method': paymentMethod,
      'transaction_id': transactionId,
      'transaction_phone_number': transactionPhoneNumber,
      'delivery_location': deliveryLocation,
      'delivery_charge': deliveryCharge,
      'items': items.map((item) => item.toJson()).toList(),
      'order_status': orderStatus,
    };
  }
}
