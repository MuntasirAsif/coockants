import 'package:cookants/core/constants/color.dart';
import 'package:cookants/data/APIs/api.dart';
import 'package:cookants/data/models/grocery_product_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../services/english ro bangla.dart';

class ProductCard extends StatelessWidget {
  final GroceryProductModel productModel;
  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.go(
            '/product/'
                '${productModel.productCategory.replaceAll(' ', '-')}/'
                '${productModel.productName.replaceAll(' ', '-')}'  // Replace spaces with dashes
                '~'
                '${productModel.productId}'
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 260,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius:BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(5),
                height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(baseApi.substring(0,29)+productModel.productImage,),fit: BoxFit.fill)
                  ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(productModel.productName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: productNameTextColor),maxLines: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          SelectableText('৳ ${convertToBanglaNumber(productModel.productCurrentPrice.toString())}',
                            style: TextStyle(fontSize: 16,color: orderButtonColor),
                          ),
                          SelectableText('/${productModel.productUnit}',style: TextStyle(fontSize: 14,color: orderButtonColor),),
                          const Gap(10),
                        ],
                      ),
                      Row(
                        children: [
                          SelectableText('৳ ${convertToBanglaNumber(productModel.productOriginalPrice.toString())}',
                            style: const TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
