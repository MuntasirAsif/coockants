import 'package:cookants/data/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:cookants/core/widgets/order_card/order_card.dart';
import '../../../../../data/models/order_model.dart';

class AdminOrderPageBody extends StatefulWidget {
  const AdminOrderPageBody({super.key});

  @override
  State<AdminOrderPageBody> createState() => _AdminOrderPageBodyState();
}

class _AdminOrderPageBodyState extends State<AdminOrderPageBody> {
  List<String> tabBarList = [
    'Pending',
    'All',
    'Confirmed',
    'Delivered',
    'Canceled',
  ];

  int selectedListIndex = 0;
  List<Order> orders = [];
  List<Order> filteredOrders = [];
  String searchQuery = '';
  OrderController orderController = OrderController();

  @override
  void initState() {
    super.initState();
    refreshItem();
  }
  void refreshItem(){
    orderController.fetchOrders().then((_) {
      setState(() {
        orders = orderController.orders.value;
        filteredOrders = orders; // Initialize with all orders
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    orders = orderController.orders.value;
    return Container(
      height: height * 0.9,
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query.toLowerCase();
                  filteredOrders = orders.where((order) {
                    return order.customerName.toLowerCase().contains(searchQuery);
                  }).toList();
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search orders by customer name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          // Tab Bar
          InkWell(
            onTap: (){
              refreshItem();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.refresh),
                Text('Refresh'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: tabBarList.asMap().entries.map((entry) {
              int index = entry.key;
              String label = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedListIndex = index;

                      if (index == 1) {
                        // "All" tab
                        filteredOrders = orders;
                      } else {
                        String status = tabBarList[index].toLowerCase();
                        filteredOrders = orders
                            .where((order) => order.orderStatus.toLowerCase() == status)
                            .toList();
                      }
                    });
                  },
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selectedListIndex == index ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // Order List
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return OrderCard(order: filteredOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
