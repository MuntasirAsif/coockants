import 'package:cookants/core/constants/color.dart';
import 'package:cookants/data/APIs/api.dart';
import 'package:cookants/data/models/grocery_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final GroceryProductModel productModel;
  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.go('/product/${productModel.productId}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 200,
        width: 180,
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius:BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              height: 150,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage(baseApi+productModel.productImage,),fit: BoxFit.fill)
                ),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productModel.productName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('৳ ${productModel.productCurrentPrice}',style: TextStyle(fontSize: 20),),
                      Gap(5),
                      Text('৳ ${productModel.productCurrentPrice}',style: TextStyle(fontSize: 14,decoration:TextDecoration.lineThrough),),
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
