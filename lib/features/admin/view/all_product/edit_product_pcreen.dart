import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cookants/data/repositories/grocery_product_repository.dart';
import '../../../../data/models/grocery_product_model.dart';

class EditProductScreen extends StatefulWidget {
  final int productId;

  const EditProductScreen({super.key, required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _productCurrentPriceController = TextEditingController();
  final TextEditingController _productOriginalPriceController = TextEditingController();
  final TextEditingController _productCategoryController = TextEditingController();
  final TextEditingController _productUnitController = TextEditingController();
  GroceryProductRepository repository = GroceryProductRepository();

  bool isLoading = false;
  late GroceryProductModel product;
  html.File? productImage;
  Uint8List? productImageBytes; // To hold the image bytes for preview

  @override
  void initState() {
    super.initState();
    _fetchProductData();
  }

  Future<void> _fetchProductData() async {
    setState(() {
      isLoading = true;
    });
    try {
      product = await repository.getProductById(widget.productId);

      // Set the fetched data to controllers
      _productNameController.text = product.productName;
      _productDescriptionController.text = product.productDescription ?? '';
      _productCurrentPriceController.text = product.productCurrentPrice.toString();
      _productOriginalPriceController.text = product.productOriginalPrice?.toString() ?? '';
      _productCategoryController.text = product.productCategory;
      _productUnitController.text = product.productUnit;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch product data: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Allow the user to pick an image
  Future<void> _pickImage() async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files?.isEmpty ?? true) return;

      setState(() {
        productImage = files!.first;
      });

      // Convert file to bytes and update the image bytes for preview
      final reader = html.FileReader();
      reader.readAsArrayBuffer(productImage!);

      reader.onLoadEnd.listen((e) {
        setState(() {
          productImageBytes = reader.result as Uint8List?;
        });
      });
    });
  }

  Future<void> updateProduct(int productId, GroceryProductModel updatedProduct, html.File? productImage) async {
    if (productImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a product image')));
      return;
    }

    try {
      final uri = Uri.parse('http://127.0.0.1:8000/products/$productId/');
      var request = http.MultipartRequest('PUT', uri);

      // Adding fields to the request
      request.fields['product_name'] = updatedProduct.productName;
      request.fields['product_description'] = updatedProduct.productDescription ?? '';
      request.fields['product_current_price'] = updatedProduct.productCurrentPrice.toString();
      request.fields['product_original_price'] = updatedProduct.productOriginalPrice?.toString() ?? '0.0';
      request.fields['product_category'] = updatedProduct.productCategory;
      request.fields['product_unit'] = updatedProduct.productUnit;

      // Attach image as a file
      final reader = html.FileReader();
      reader.readAsArrayBuffer(productImage);

      reader.onLoadEnd.listen((e) async {
        final fileBytes = reader.result as List<int>;
        final multipartFile = http.MultipartFile.fromBytes(
          'product_image',
          fileBytes,
          filename: productImage.name,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);

        // Send request
        final response = await request.send();

        // Check response status
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product updated successfully')));
        } else {
          final responseBody = await response.stream.bytesToString();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update product: $responseBody')));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error occurred while updating: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter product name' : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _productDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Enter product description' : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _productCurrentPriceController,
                decoration: const InputDecoration(
                  labelText: 'Current Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter current price' : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _productOriginalPriceController,
                decoration: const InputDecoration(
                  labelText: 'Original Price (Optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _productCategoryController,
                decoration: const InputDecoration(
                  labelText: 'Product Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter product category' : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _productUnitController,
                decoration: const InputDecoration(
                  labelText: 'Product Unit (e.g., kg, pcs)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter product unit' : null,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _pickImage, // Open image picker
                child: Text(productImage == null ? 'Pick an Image' : 'Change Image'),
              ),
              const SizedBox(height: 16.0),
              // Show image preview if image is selected
              if (productImageBytes != null)
                Image.memory(
                  productImageBytes!,
                  width: 200, // Specify the width of the image preview
                  height: 200, // Specify the height of the image preview
                  fit: BoxFit.cover, // Set the fit as you prefer
                ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final updatedProduct = GroceryProductModel(
                      productId: widget.productId,
                      productName: _productNameController.text,
                      productDescription: _productDescriptionController.text,
                      productCurrentPrice: double.parse(_productCurrentPriceController.text),
                      productOriginalPrice: double.tryParse(_productOriginalPriceController.text),
                      productCategory: _productCategoryController.text,
                      productUnit: _productUnitController.text,
                      productImage: '', // You can choose to store this in the database if needed
                    );
                    updateProduct(widget.productId, updatedProduct, productImage);
                  }
                },
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
