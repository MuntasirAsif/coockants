import 'package:cookants/data/controller/grocery_product_controller.dart';
import 'package:cookants/data/models/grocery_product_model.dart';
import 'package:cookants/features/user/view/product_page/product_page_body.dart';
import 'package:flutter/material.dart';
import 'package:seo/head_tag.dart';
import 'package:seo/html/seo_widget.dart';
import '../../../../core/constants/color.dart';
import '../../../../data/repositories/grocery_product_repository.dart';
import '../landing_page/desktop_view/footer/d_footer_widgets.dart';
import '../landing_page/desktop_view/header/widgets/d_title_bar.dart';
import '../landing_page/mobile_view/footer/m_footer_widgets.dart';
import '../landing_page/mobile_view/header/widgets/m_title_bar.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  const ProductPage({super.key, required this.productId, required String productCategory, required String productName});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final GroceryProductController groceryProductController;
  GroceryProductModel? product; // Nullable
  bool isLoading = false;
  GroceryProductRepository repository = GroceryProductRepository();

  Future<void> _fetchProductData() async {
    setState(() {
      isLoading = true;
    });
    try {
      product = await repository.getProductById(int.parse(widget.productId));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch product data: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    groceryProductController = GroceryProductController();
    _fetchProductData(); // Fetch data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Seo.head(
      tags: [
        MetaTag(name: 'Cookants - ${product?.productName}', content: product?.productDescription),
        LinkTag(rel: product?.productName, href: 'https://www.cookantsfresh.com/product/${product?.productCategory}/${product?.productName}~${product?.productId}'),
      ],
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 700) {
              return SingleChildScrollView(child: desktopView(context));
            } else {
              return SingleChildScrollView(child: mobileView(context));
            }
          },
        ),
      ),
    );
  }

  Widget mobileView(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: headerBgColor,
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03, vertical: 5),
          child: MTitleBar(deviceHeight: deviceHeight, deviceWidth: deviceWidth),
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : product != null
            ? ProductPageBody(productModel: product!)
            : const Center(child: Text('Product not found')),
        const MFooterWidgets(),
      ],
    );
  }

  Widget desktopView(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: headerBgColor,
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
          child: DTitleBar(deviceHeight: deviceHeight, deviceWidth: deviceWidth),
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : product != null
            ? ProductPageBody(productModel: product!)
            : const Center(child: Text('Product not found')),
        const DFooterWidgets(),
      ],
    );
  }
}
