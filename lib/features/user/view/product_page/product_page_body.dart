import 'package:cookants/core/widgets/button_widgets.dart';
import 'package:cookants/data/models/grocery_product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color.dart';

class ProductPageBody extends StatelessWidget {
  final GroceryProductModel productModel;
  const ProductPageBody({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 700;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isDesktop ? _buildDesktopView(context) : _buildMobileView(context),
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(false),
        const SizedBox(height: 10),
        _buildProductInfo(),
        const SizedBox(height: 10),
        _buildDescription(),
        const SizedBox(height: 20),
        _buildPriceSection(),
        const SizedBox(height: 20),
        _buildAddToCartButton(context),
      ],
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildProductImage(true)),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductInfo(),
              const SizedBox(height: 10),
              _buildDescription(),
              const SizedBox(height: 20),
              _buildPriceSection(),
              const SizedBox(height: 20),
              _buildAddToCartButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(bool isDesktop) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        productModel.productImage,
        fit: BoxFit.fitHeight,
        width: double.infinity,
        height: isDesktop?400:250,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel.productName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            Chip(
              label: Text(productModel.productCategory),
              backgroundColor: loginButtonColor.withOpacity(.7),
            ),
            Chip(
              label: Text(productModel.productUnit),
              backgroundColor: loginButtonColor.withOpacity(.4),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      productModel.productDescription ?? 'No description available.',
      style: const TextStyle(fontSize: 16, color: Colors.black54),
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          productModel.productCurrentPrice.toStringAsFixed(2),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        const SizedBox(width: 10),
        if (productModel.productOriginalPrice != null && productModel.productOriginalPrice! > 0)
          Text(
            productModel.productOriginalPrice!.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 18,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return SizedBox(
      width: 200,
        child: InkWell(
            onTap: (){
              context.go('/order/${productModel.productCategory}');
            },
            child: ButtonWidgets(name: 'অর্ডার করুন', color: orderButtonColor)));
  }
}
