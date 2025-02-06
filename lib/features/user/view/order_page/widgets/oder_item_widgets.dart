import 'package:cookants/data/APIs/api.dart';
import 'package:cookants/data/models/grocery_product_model.dart';
import 'package:cookants/data/repositories/grocery_product_repository.dart';
import 'package:cookants/features/admin/view/all_product/edit_product_pcreen.dart';
import 'package:cookants/features/user/controller/price_calculation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OderItemWidgets extends StatefulWidget {
  bool isAdmin;
  GroceryProductModel productModel;
  PriceCalculation priceCalculation;
  int totalPrice;
  List<Map<String, Map<String, int>>> selectedProduct;
  OderItemWidgets(
      {super.key,
      this.isAdmin = false,
      required this.productModel,
      required this.priceCalculation,
      required this.totalPrice,
      required this.selectedProduct});

  @override
  State<OderItemWidgets> createState() => _OderItemWidgetsState();
}

class _OderItemWidgetsState extends State<OderItemWidgets> {
  GroceryProductRepository groceryProductRepository =
      GroceryProductRepository();
  double quantity = 0; // Initial quantity
  late double pricePerKg; // Price per unit (or per kg)
  String convertNumber(double bnPrice) {
    String enPrice = '';
    for (int i = 0; i < bnPrice; i++) {
      switch (bnPrice) {
        case '১':
          enPrice = '${enPrice}1';
          break;
        case '২':
          enPrice = '${enPrice}2';
          break;
        case '৩':
          enPrice = '${enPrice}3';
          break;
        case '৪':
          enPrice = '${enPrice}4';
          break;
        case '৫':
          enPrice = '${enPrice}5';
          break;
        case '৬':
          enPrice = '${enPrice}6';
          break;
        case '৭':
          enPrice = '${enPrice}7';
          break;
        case '৮':
          enPrice = '${enPrice}8';
          break;
        case '৯':
          enPrice = '${enPrice}9';
          break;
        case '.':
          enPrice = '${enPrice}.';
          break;
        default:
          enPrice = '${enPrice}0';
      }
      ;
    }
    return enPrice;
  }

  @override
  Widget build(BuildContext context) {
    pricePerKg = widget.productModel.productCurrentPrice;
    return InkWell(
      onTap: () {
        widget.isAdmin
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProductScreen(
                        productId: widget.productModel.productId)))
            : context.go('/product/${widget.productModel.productId}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF4E6E6), // Background color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Product Image
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  baseApi +
                      widget.productModel
                          .productImage, // Replace with your image URL
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Weight
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.productModel.productName} (${widget.productModel.productUnit})", // Product name
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF293A54),
                          ),
                        ),
                      ),
                      widget.isAdmin?InkWell(
                          onTap: () {
                            groceryProductRepository
                                .deleteProduct(widget.productModel.productId);
                          },
                          child: const Icon(Icons.delete)):SizedBox()
                    ],
                  ),
                  Text(
                    "${widget.productModel.productCurrentPrice}৳", // Total price
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF293A54),
                    ),
                  ),
                  // Price
                  widget.isAdmin
                      ? SizedBox()
                      : Text(
                          "${pricePerKg * quantity}৳", // Total price
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF293A54),
                          ),
                        ),
                  widget.isAdmin
                      ? Expanded(
                          child: Text(
                            "${widget.productModel.productDescription}", // Product name
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF293A54),
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            // Decrease Button
                            IconButton(
                              onPressed: () {
                                if (quantity > 0) {
                                  setState(() {
                                    quantity--;
                                    widget.priceCalculation.addProduct(
                                        widget.productModel.productId
                                            .toString(),
                                        widget.productModel.productName,
                                        pricePerKg,
                                        quantity,
                                        widget.productModel.productImage);
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove,
                                  color: Color(0xFF293A54)),
                            ),

                            // Quantity Display
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD2D2D2)),
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              child: Text(
                                "$quantity", // Display quantity
                                style: const TextStyle(
                                    fontSize: 14, color: Color(0xFF293A54)),
                              ),
                            ),

                            // Increase Button
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                  widget.priceCalculation.addProduct(
                                      widget.productModel.productId.toString(),
                                      widget.productModel.productName,
                                      pricePerKg,
                                      quantity,
                                      widget.productModel.productImage);
                                });
                              },
                              icon: const Icon(Icons.add,
                                  color: Color(0xFF293A54)),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
