import 'package:cookants/data/controller/grocery_product_controller.dart';
import 'package:cookants/features/user/controller/price_calculation.dart';
import 'package:cookants/features/user/view/order_page/widgets/price_calculation_widgets.dart';
import 'package:cookants/features/user/view/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../data/models/grocery_product_model.dart';
import '../../../controller/horizontal_scrolling_controller.dart';
import 'oder_item_widgets.dart';

class OrderPageBody extends StatefulWidget {
  final String category;
  const OrderPageBody({super.key, required this.category});

  @override
  State<OrderPageBody> createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
  late final HorizontalScrollController _scrollController;
  PriceCalculation priceCalculation = PriceCalculation();
  List<GroceryProductModel> products = [];
  GroceryProductController groceryProductController =
      GroceryProductController();
  int total = 0;
  List<Map<String, Map<String, int>>> selectedProduct = [];
  @override
  void initState() {
    super.initState();
    _scrollController = HorizontalScrollController();
    reassemble();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<List<GroceryProductModel>> loadProducts(String category) async {
    await groceryProductController.fetchProducts();
    List<GroceryProductModel> allProducts = groceryProductController.products ?? [];



    // Sorting products: selected category first
    if(category=='all'){
      return allProducts;// Prevents null return
    }else{
      allProducts.sort((a, b) {
        if (a.productCategory == widget.category && b.productCategory != widget.category) {
          return -1; // `a` comes before `b`
        } else if (a.productCategory != widget.category && b.productCategory == widget.category) {
          return 1; // `b` comes before `a`
        } else {
          return 0; // Keep the original order
        }
      });

      return allProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Gap(20),
        const Text(
          'আপনার পন্য সিলেক্ট করুন',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const Text(
          'আমরা আপনার অবস্থানের কাছাকাছি সেরা মানের এবং সতেজ\nজিনিসপত্র সরবরাহ করি',
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 15,
              child: Center(
                child: IconButton(
                  onPressed: _scrollController.scrollLeft,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(10),
              width: deviceWidth * 0.8,
              height: 650,
              decoration: BoxDecoration(border: Border.all()),
              child: FutureBuilder<List<GroceryProductModel>>(
                future: loadProducts(widget.category),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final products = snapshot.data!;
                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController.scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Number of columns
                        crossAxisSpacing: 10, // Spacing between columns
                        mainAxisSpacing: 10, // Spacing between rows
                        childAspectRatio:
                            0.4, // Adjust aspect ratio for card height/width
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return OderItemWidgets(
                          productModel: products[index],
                          priceCalculation: priceCalculation,
                          totalPrice: total,
                          selectedProduct: selectedProduct,
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No products available.'));
                  }
                },
              ),
            ),
            const Gap(10),
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 15,
              child: Center(
                child: IconButton(
                  onPressed: _scrollController.scrollRight,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        Obx(() => PriceCalculationWidget(
              selectedProducts: priceCalculation.selectedProducts.value,
              totalPrice: priceCalculation.totalPrice.value,
            ))
      ],
    );
  }
}
