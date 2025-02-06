import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  _UploadProductScreenState createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productCurrentPrice = TextEditingController();
  final TextEditingController _productOriginalPrice = TextEditingController();
  final TextEditingController _productCategory = TextEditingController();
  final TextEditingController _productUnit = TextEditingController();
  String? _selectedCategory;
  String? _productImagePath;
  Uint8List? _productImageBytes;
  bool _isUploading = false;
  final ImagePicker _imagePicker = ImagePicker();

  late html.FileUploadInputElement uploadInput;

  @override
  void initState() {
    super.initState();

    // Initialize the file input for web
    uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.onChange.listen((event) async {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) {
        if (reader.result is Uint8List) {
          setState(() {
            _productImageBytes = reader.result as Uint8List;
            _productImagePath = file.name;
          });
        } else {
          if (kDebugMode) {
            print("Error: Expected Uint8List, got ${reader.result.runtimeType}");
          }
        }
      });
    });
  }

  // Pick image for mobile
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _productImagePath = pickedFile.path;
        _productImageBytes = null; // Clear web image bytes if any
      });
    }
  }

  // Function to send a GET request to retrieve CSRF token from cookies

  // Upload product to server
  Future<void> _uploadProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isUploading = true;
    });

    final uri = Uri.parse('http://127.0.0.1:8000/upload/');

    // Retrieve CSRF token


    final request = http.MultipartRequest('POST', uri);

    request.fields['product_name'] = _productName.text;
    request.fields['product_description'] = _productDescription.text;
    request.fields['product_category'] = _selectedCategory!;
    request.fields['product_unit'] = _productUnit.text;

    if (_productCurrentPrice.text.isNotEmpty &&
        _productOriginalPrice.text.isNotEmpty) {
      request.fields['product_current_price'] =
          int.parse(_productCurrentPrice.text).toString();
      request.fields['product_original_price'] =
          int.parse(_productOriginalPrice.text).toString();
    } else {
      if (kDebugMode) {
        print("Price fields cannot be empty");
      }
    }

    // Check for product image and prepare for upload
    if (_productImageBytes != null || _productImagePath != null) {
      final fileBytes =
          _productImageBytes ?? await _getFileBytesFromPath(_productImagePath!);

      final multipartFile = http.MultipartFile.fromBytes(
        'product_image',
        fileBytes,
        filename: _productImagePath!.split('/').last, // Ensure a valid filename
      );
      request.files.add(multipartFile);

      try {
        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print("Product uploaded successfully: $responseBody");
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product uploaded successfully')),
          );
        } else {
          if (kDebugMode) {
            print("Failed to upload product: $responseBody");
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload product')),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error occurred while uploading: $e");
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error uploading product')),
        );
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  // Function to get file bytes from the path (used for mobile)
  Future<Uint8List> _getFileBytesFromPath(String path) async {
    // Use File or some other method to load the file
    final response = await http.get(Uri.parse(path));
    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(child: buildGestureDetector(isDesktop)),
                    const Gap(20),
                    SizedBox(width: 500, child: buildColumn()),
                  ],
                )
              : Column(
                  children: [
                    buildGestureDetector(isDesktop),
                    const Gap(20),
                    buildColumn(),
                  ],
                ),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Product Name",
            border: OutlineInputBorder(),
          ),
          controller: _productName,
          validator: (value) =>
              value == null || value.isEmpty ? 'Enter product name' : null,
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Product Description",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          controller: _productDescription,
          validator: (value) => value == null || value.isEmpty
              ? 'Enter product description'
              : null,
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Current Price",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _productCurrentPrice,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter current price'
                    : null,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Original Price (Optional)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _productOriginalPrice,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        PopupMenuButton<String>(
          onSelected: (String value) {
            setState(() {
              _selectedCategory = value;
              if (kDebugMode) {
                print(_selectedCategory);
              }
            });
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: 'Fruits and Pickles',
              child: Text('Fruits and Pickles'),
            ),
            const PopupMenuItem(
              value: 'Fresh Meats',
              child: Text('Fresh Meats'),
            ),
            const PopupMenuItem(
              value: 'Fresh Fishes',
              child: Text('Fresh Fishes'),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedCategory??  'Select Product Category',
                  style: TextStyle(
                    color: _selectedCategory == null ? Colors.grey : Colors.black,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Product Unit (e.g., kg, pcs)",
            border: OutlineInputBorder(),
          ),
          controller: _productUnit,
          validator: (value) =>
              value == null || value.isEmpty ? 'Enter product unit' : null,
        ),
        const SizedBox(height: 24.0),
        _isUploading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _uploadProduct,
                child: const Text("Upload Product"),
              ),
      ],
    );
  }

  GestureDetector buildGestureDetector(bool isDesktop) {
    return GestureDetector(
      onTap: isDesktop ? () => uploadInput.click() : _pickImage,
      child: Container(
        height: isDesktop ? 300 : 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: _productImagePath == null
            ? const Center(
                child: Text(
                  "Tap to add an image",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : _productImageBytes != null
                ? Image.memory(
                    _productImageBytes!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    _productImagePath!,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}
