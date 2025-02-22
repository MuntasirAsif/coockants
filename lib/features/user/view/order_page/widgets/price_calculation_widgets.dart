import 'package:cookants/data/APIs/api.dart';
import 'package:cookants/data/controller/order_controller.dart';
import 'package:cookants/data/models/order_item_model.dart';
import 'package:cookants/data/models/order_model.dart';
import 'package:cookants/features/user/controller/price_calculation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../core/constants/color.dart';

class PriceCalculationWidget extends StatefulWidget {
  final List<OrderItem> selectedProducts;
  final double totalPrice;

  const PriceCalculationWidget({
    super.key,
    required this.selectedProducts,
    required this.totalPrice,
  });

  @override
  State<PriceCalculationWidget> createState() => _PriceCalculationWidgetState();
}

class _PriceCalculationWidgetState extends State<PriceCalculationWidget> {
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
          break;
          case '.':
          bengali = '$bengali.';
          break;
        default:
          bengali = '$bengali০';
      }
    }
    return bengali;
  }

  final ScrollController scrollController = ScrollController();
  String paymentSelectedOption=''; // Store the selected option
  String locationSelectedOption=''; // Store the selected option
  double deliveryCharge = 0;

  OrderController orderController = OrderController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerNoController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController transactionNoController = TextEditingController();
  TextEditingController transactionIDController = TextEditingController();
  PriceCalculation priceCalculation = PriceCalculation();

  List<OrderItem> selectedItem= [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      selectedItem = widget.selectedProducts;
    });
    double deviceWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 750) {
          return deskTopView(deviceWidth);
        } else {
          return mobileView(deviceWidth);
        }
      });
  }
  Widget mobileView(double deviceWidth) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userInfo(deviceWidth),
          pricePart(deviceWidth),
        ],
      ),
    );
  }

  Widget deskTopView(double deviceWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: deviceWidth * 0.4,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
            child: userInfo(deviceWidth)),
        Container(
            width: deviceWidth * 0.35,
            padding: const EdgeInsets.all(16.0),
            child: pricePart(deviceWidth)),
      ],
    );
  }

  Widget userInfo(double deviceWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'অর্ডার করতে তথ্য দিন',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'আপনার নাম লিখুন',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: customerNameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text(
              'আপনার ফোন নাম্বার লিখুন',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: customerNoController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text(
              'গ্রাম,থানা,জেলাসহ বর্তমান ঠিকানা লিখুন',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: customerAddressController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text(
              'পেমেন্ট সিস্টেম',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              value: 'Cash on Delivery',
              groupValue: paymentSelectedOption,
              title: const Text('ক্যাশ অন ডেলিভারি'),
              onChanged: (value) {
                setState(() {
                  paymentSelectedOption = value!;
                });
              },
            ),
            RadioListTile<String>(
              value: 'Bkash/Rocket/Nagad',
              groupValue: paymentSelectedOption,
              title: const Text('বিকাশ / রকেট / নগদ'),
              onChanged: (value) {
                setState(() {
                  paymentSelectedOption = value!;
                });
              },
            ),
            paymentSelectedOption == 'Bkash/Rocket/Nagad'
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'ট্রানজেকশন নাম্বার:',
                            ),
                            Gap(10),
                            SizedBox(
                              width: 280,
                              child: TextField(
                                controller: transactionNoController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        const Text(
                          'মোবাইল নাম্বার:',
                        ),
                        Gap(10),
                        SizedBox(
                          width: 280,
                          child: TextField(
                            controller: transactionIDController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            const Text(
              'ডেলিভারি কোথায় নিবেন?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              value: 'ঢাকার ভিতরে',
              groupValue: locationSelectedOption,
              title: Row(
                children: [
                  const Text('ঢাকার ভিতরে'),
                  Gap(deviceWidth * 0.03),
                  const Text('৬০৳'),
                ],
              ),
              onChanged: (value) {
                setState(() {
                  locationSelectedOption = value!;
                  deliveryCharge = 60;
                });
              },
            ),
            RadioListTile<String>(
              value: 'ঢাকার বাহিরে',
              groupValue: locationSelectedOption,
              title: Row(
                children: [
                  const Text('ঢাকার বাহিরে'),
                  Gap(deviceWidth * 0.03),
                  const Text('১২০৳'),
                ],
              ),
              onChanged: (value) {
                setState(() {
                  locationSelectedOption = value!;
                  deliveryCharge = 120;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget pricePart(double deviceWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'আপনার অর্ডার',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        widget.selectedProducts.isEmpty
            ? const Center(
                child: Text(
                  'No products added yet.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )
            : RawScrollbar(
                controller: scrollController,
                thumbColor: Colors.black26,
                radius: const Radius.circular(10),
                thickness: 6.0,
                thumbVisibility:
                    true, // Ensures the scrollbar thumb is always visible
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                          label: Text('পণ্য',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('দর  x  পরিমান',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('মোট',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: widget.selectedProducts.map((productEntry) {
                      final productName = productEntry.productName;
                      final price = productEntry.price;
                      final quantity = productEntry.quantity;
                      final total = price * quantity;
                      final imageUrl = baseApi+productEntry.imageUrl;

                      return DataRow(cells: [
                        DataCell(Row(
                          children: [
                            Container(
                              width: 50,
                              height: 60,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover)),
                            ),
                            Text(productName),
                          ],
                        )),
                        DataCell(Text(
                            '${convertNumber(price)} x ${convertNumber(quantity)}')),
                        DataCell(Text('${convertNumber(total)} ৳')),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'সর্বমোট খরচ: ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    '${convertNumber(widget.totalPrice)} ৳',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              deliveryCharge != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'ডেলিভারি খরচ: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          locationSelectedOption == 'ঢাকার বাহিরে'
                              ? '১২০ ৳'
                              : '৬০ ৳',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              print("Selected Products: ${widget.selectedProducts}");
              print("Selected Item: $selectedItem");

              Order order = Order(
                customerName: customerNameController.text.toString(),
                customerPhoneNumber: customerNoController.text.toString(),
                address: customerAddressController.text.toString(),
                paymentMethod: paymentSelectedOption,
                transactionPhoneNumber: transactionNoController.text.toString(),
                transactionId: transactionIDController.text.toString(),
                deliveryLocation: customerAddressController.text.toString(),
                deliveryCharge: deliveryCharge,
                items: selectedItem,
                orderStatus: 'pending',
              );
              orderController.addOrder(order,context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              backgroundColor: orderButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'অর্ডার করুন    ${convertNumber(widget.totalPrice + deliveryCharge)} ৳',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
