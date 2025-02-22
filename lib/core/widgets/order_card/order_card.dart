import 'package:cookants/data/APIs/api.dart';
import 'package:cookants/data/controller/order_controller.dart';
import 'package:cookants/features/admin/view/admin_order_page/Widgets/edit_order.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../data/models/order_model.dart';
import '../../../services/pose_service.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;
  String convertNumber(double eng) {
    String bengali = '';
    for (int i = 0; i < eng.toString().length; i++) {
      switch (eng.toString()[i]) {
        case '1':
          bengali = '$bengali১';
          break;
        case '2':
          bengali = '$bengali২';
          break;
        case '3':
          bengali = '$bengali৩';
          break;
        case '4':
          bengali = '$bengali৪';
          break;
        case '5':
          bengali = '$bengali৫';
          break;
        case '6':
          bengali = '$bengali৬';
          break;
        case '7':
          bengali = '$bengali৭';
          break;
        case '8':
          bengali = '$bengali৮';
          break;
        case '9':
          bengali = '$bengali৯';
        case '.':
          bengali = '$bengali.';
          break;
        default:
          bengali = '$bengali০';
      }
    }
    return bengali;
  }

  double _calculateTotalAmount() {
    double totalItemsCost = widget.order.items.fold(0.0, (sum, productEntry) {
      return sum + (productEntry.price * productEntry.quantity);
    });

    // Add delivery charge to the total cost
    double totalCost = totalItemsCost + widget.order.deliveryCharge;

    return totalCost;
  }

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double total = _calculateTotalAmount();
    double totalCost = total.toDouble();
    return InkWell(
      onTap: () => setState(() {
        isExpanded = !isExpanded;
      }),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Info
              Text(
                'Customer: ${widget.order.customerName}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Phone: ${widget.order.customerPhoneNumber}'),
              const SizedBox(height: 8),
              Text('Address: ${widget.order.address}'),
              const SizedBox(height: 8),
              Text('Payment Method: ${widget.order.paymentMethod}'),
              isExpanded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        if (widget.order.paymentMethod ==
                            'Bkash/Rocket/Nagad') ...[
                          Text(
                              'Transaction ID: ${widget.order.transactionId ?? "N/A"}'),
                          Text(
                              'Transaction Phone: ${widget.order.transactionPhoneNumber ?? "N/A"}'),
                        ],
                        SizedBox(
                          width: 350,
                          child: Column(
                            children: [
                              RawScrollbar(
                                controller: scrollController,
                                thumbColor: Colors.black26,
                                radius: const Radius.circular(10),
                                thickness: 6.0,
                                thumbVisibility:
                                    true, // Ensures the scrollbar thumb is always visible
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: scrollController,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(
                                          label: Text('পণ্য',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('দর  x  পরিমান',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('মোট',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                    rows:
                                        widget.order.items.map((productEntry) {
                                      final productName =
                                          productEntry.productName;
                                      final price = productEntry.price;
                                      final quantity = productEntry.quantity;
                                      final total = price * quantity;
                                      final imageUrl = baseApi.substring(0,baseApi.length-1)+productEntry.imageUrl;

                                      return DataRow(cells: [
                                        DataCell(Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 60,
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          imageUrl),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Text(productName),
                                          ],
                                        )),
                                        DataCell(Text(
                                            '${convertNumber(price)} x ${convertNumber(quantity)}')),
                                        DataCell(
                                            Text('${convertNumber(total)} ৳')),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'সর্বমোট খরচ: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    '${convertNumber(totalCost)} ৳',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'সর্বমোট খরচ + ডেলিভারি চার্জ : ',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Gap(10),
                                  Text(
                                    '${convertNumber(totalCost + widget.order.deliveryCharge.toInt())} ৳',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            'Delivery Location: ${widget.order.address}'),
                        const SizedBox(height: 8),
                        Text(
                            'Delivery Charge: ৳${widget.order.deliveryCharge.toStringAsFixed(2)}'),
                        const SizedBox(height: 16),
                      ],
                    )
                  : const SizedBox(),

              // Order Status
              Gap(20),

              Row(
                children: [
                  InkWell(
                    onTap: (){
                      printReceiptWeb(widget.order, total+widget.order.deliveryCharge,total);
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: getStatusColor(widget.order.orderStatus),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Print',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Gap(20),
                  InkWell(
                    onTap: (){
                      printReceiptDownload(widget.order, total+widget.order.deliveryCharge,total);
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: getStatusColor(widget.order.orderStatus),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Download',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Gap(20),
                  InkWell(
                    onTap: (){
                      setState(() {
                        OrderController orderController = OrderController();
                        int? id = widget.order.orderId;
                        orderController.deleteOrder(id!,context);
                      });
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: getStatusColor(widget.order.orderStatus),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                       'Delete',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Gap(20),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderPage(order: widget.order)));
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: getStatusColor(widget.order.orderStatus),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                       'Edit',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
