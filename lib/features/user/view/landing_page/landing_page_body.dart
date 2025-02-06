import 'package:cookants/core/widgets/button_widgets.dart';
import 'package:cookants/core/widgets/product_card/product_card.dart';
import 'package:cookants/data/controller/grocery_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color.dart';
import '../../../../data/models/grocery_product_model.dart';
import '../../controller/horizontal_scrolling_controller.dart';

class LandingPageBody extends StatefulWidget {
  const LandingPageBody({super.key});

  @override
  State<LandingPageBody> createState() => _LandingPageBodyState();
}

class _LandingPageBodyState extends State<LandingPageBody> {
  late final HorizontalScrollController _scrollController;
  late final HorizontalScrollController _fishScrollController;
  late final HorizontalScrollController _metScrollController;
  late final HorizontalScrollController _othersScrollController;
  final GroceryProductController groceryProductController =
      GroceryProductController();
  List<GroceryProductModel> groceryProducts = [];

  @override
  void initState() {
    super.initState();
    _scrollController = HorizontalScrollController();
    _fishScrollController = HorizontalScrollController();
    _metScrollController = HorizontalScrollController();
    _othersScrollController = HorizontalScrollController();
    groceryProductController.fetchProducts();
    groceryProducts = groceryProductController.products;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fishScrollController.dispose();
    _metScrollController.dispose();
    _othersScrollController.dispose();
    super.dispose();
  }

  late double deviceWidth;
  late double deviceHeight;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(50),
          allItem(deviceWidth, groceryProducts),
          const Gap(20),
          metItem(deviceWidth, groceryProducts),
          const Gap(20),
          fishItem(deviceWidth, groceryProducts),
          const Gap(20),
          othersItem(deviceWidth, groceryProducts),
          const Gap(20),
        ],
      ),
    );
  }

  Column allItem(
      double deviceWidth, List<GroceryProductModel> groceryProducts) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
          child: const Text(
            'সব আইটেম',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
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
            Expanded(
              child: Obx(() {
                if (groceryProductController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (groceryProductController.products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                return SizedBox(
                  height: 220,
                  width: deviceWidth,
                  child: ListView.builder(
                    controller: _scrollController.scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: groceryProductController.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                          productModel:
                              groceryProductController.products[index]);
                    },
                  ),
                );
              }),
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
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  height: 60,
                  width: 150,
                  child: InkWell(
                    onTap: () {
                      context.go('/order/all');
                    },
                    child: ButtonWidgets(
                        name: 'অর্ডার করুন', color: orderButtonColor),
                  )),
            ))
      ],
    );
  }

  Widget fishItem(
      double deviceWidth, List<GroceryProductModel> groceryProducts) {
    // Filter products under 'মাছ' category
    final List<GroceryProductModel> fishProducts = groceryProducts
        .where((product) => product.productCategory == 'Fresh Fishes')
        .toList();

    // Return UI if products are available
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
                child: const Text(
                  'Fresh Fishes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 15,
                    child: Center(
                      child: IconButton(
                        onPressed: _fishScrollController.scrollLeft,
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 220,
                      width: deviceWidth,
                      child: Obx(() {
                        if (groceryProductController.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (groceryProductController.products.isEmpty) {
                          return const Center(child: Text('No products available.'));
                        }

                        return SizedBox(
                          height: 220,
                          width: deviceWidth,
                          child: ListView.builder(
                            controller: _scrollController.scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: groceryProducts
                                .where((product) =>
                                    product.productCategory == 'Fresh Fishes')
                                .toList()
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard(
                                  productModel: groceryProducts
                                      .where((product) =>
                                          product.productCategory == 'Fresh Fishes')
                                      .toList()[index]);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 15,
                    child: Center(
                      child: IconButton(
                        onPressed: _fishScrollController.scrollRight,
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 10),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 60,
                    width: 150,
                    child: InkWell(
                      onTap: () {
                        context.go('/order/Fresh Fishes');
                      },
                      child: ButtonWidgets(
                          name: 'অর্ডার করুন', color: orderButtonColor),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget metItem(
      double deviceWidth, List<GroceryProductModel> groceryProducts) {
    // Filter the products based on the 'মাছ' category
    final List<GroceryProductModel> fishProducts = groceryProducts
        .where((product) => product.productCategory == 'Fresh Meats')
        .toList();

    return  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
                child: const Text(
                  'Fresh Meats',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Center(
                      child: IconButton(
                        onPressed: _metScrollController.scrollLeft,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: SizedBox(
                      height: 220,
                      width: deviceWidth,
                      child: Obx(() {
                        if (groceryProductController.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (groceryProductController.products.isEmpty) {
                          return const Center(child: Text('No products available.'));
                        }

                        return SizedBox(
                          height: 220,
                          width: deviceWidth,
                          child: ListView.builder(
                            controller: _scrollController.scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: groceryProducts
                                .where((product) =>
                                    product.productCategory == 'Fresh Meats')
                                .toList()
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard(
                                  productModel: groceryProducts
                                      .where((product) =>
                                          product.productCategory == 'Fresh Meats')
                                      .toList()[index]);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  const Gap(10),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 15,
                    child: Center(
                      child: IconButton(
                        onPressed: _metScrollController.scrollRight,
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
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 60,
                    width: 150,
                    child: InkWell(
                      onTap: () {
                        context.go('/order/Fresh Meats');
                      },
                      child: ButtonWidgets(
                          name: 'অর্ডার করুন', color: orderButtonColor),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Column othersItem(
      double deviceWidth, List<GroceryProductModel> groceryProducts) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
          child: const Text(
            'Fruits and Pickles',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black,
              child: Center(
                child: IconButton(
                  onPressed: _othersScrollController.scrollLeft,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: SizedBox(
                height: 220,
                width: deviceWidth,
                child: Obx(() {
                  if (groceryProductController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (groceryProductController.products.isEmpty) {
                    return const Center(child: Text('No products available.'));
                  }

                  return SizedBox(
                    height: 220,
                    width: deviceWidth,
                    child: ListView.builder(
                      controller: _scrollController.scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: groceryProducts
                          .where((product) =>
                              (product.productCategory == 'Fruits and Pickles'))
                          .toList()
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                            productModel: groceryProducts
                                .where((product) =>
                                    (product.productCategory == 'Fruits and Pickles'))
                                .toList()[index]);
                      },
                    ),
                  );
                }),
              ),
            ),
            const Gap(10),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black,
              child: Center(
                child: IconButton(
                  onPressed: _othersScrollController.scrollRight,
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
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 60,
              width: 150,
              child: InkWell(
                onTap: () {
                  context.go('/order/Fruits and Pickles');
                },
                child: ButtonWidgets(
                    name: 'অর্ডার করুন', color: orderButtonColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
