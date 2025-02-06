import 'package:cookants/features/admin/view/upload_product_screen/upload_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/controller/grocery_product_controller.dart';
import '../../../../data/models/grocery_product_model.dart';
import '../../../user/controller/horizontal_scrolling_controller.dart';
import '../../../user/controller/price_calculation.dart';
import '../../../user/view/order_page/widgets/oder_item_widgets.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  late final HorizontalScrollController _scrollController;
  PriceCalculation priceCalculation = PriceCalculation();
  List<GroceryProductModel> products = [];
  GroceryProductController groceryProductController = GroceryProductController();
  int total = 0;
  List<Map<String, Map<String, int>>> selectedProduct = [];
  final TextEditingController _searchController = TextEditingController();
  List<GroceryProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _scrollController = HorizontalScrollController();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchController.dispose();
  }

  Future<List<GroceryProductModel>> loadProducts() async {
    await groceryProductController.fetchProducts();
    return groceryProductController.products ?? [];
  }
  String pre='';
  bool first=true;
  // The function to filter products based on search query
  void _filterProducts() {
    String query = _searchController.text.toLowerCase();

      if(query!=pre || first){
        setState(() {
          filteredProducts = products
              .where((product) =>
          product.productName.toLowerCase().contains(query) ||
              product.productCategory.toLowerCase().contains(query))
              .toList();
          pre=query;
          first =false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            const Text(
              'All Product',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth*.2),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search products',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
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
                  height: deviceHeight * 0.9,
                  decoration: BoxDecoration(border: Border.all()),
                  child: FutureBuilder<List<GroceryProductModel>>(
                    future: loadProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        products = snapshot.data!;

                        // After loading products, we filter them once the future is done
                        // Filter only once the data is loaded and builder is completed
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _filterProducts();
                        });

                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController.scrollController,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.4,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            return OderItemWidgets(
                              isAdmin: true,
                              productModel: filteredProducts[index],
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadProductScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
