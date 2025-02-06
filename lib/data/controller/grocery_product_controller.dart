import 'package:get/get.dart';
import '../models/grocery_product_model.dart';
import '../repositories/grocery_product_repository.dart';

class GroceryProductController extends GetxController {
  final GroceryProductRepository repository = GroceryProductRepository();

  // State variables
  RxList<GroceryProductModel> products = <GroceryProductModel>[].obs;
  RxBool isLoading = false.obs;
  var product = Rx<GroceryProductModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Load products when the controller is initialized
  }

  // Fetch all products
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      List<GroceryProductModel> fetchedProducts = await repository.getAllProducts();
      products.assignAll(fetchedProducts);

    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductById(String id) async {
    try {
      isLoading.value = true;
      GroceryProductModel fetchedProduct = await repository.getProductById(int.parse(id));
      product.value = fetchedProduct; // Assign the fetched product to the observable
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Add a product
  Future<void> addProduct(GroceryProductModel product) async {
    try {
      isLoading.value = true;
      await repository.addProduct(product);
      products.add(product);
      Get.snackbar('Success', 'Product added successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update a product
// Update product
  Future<void> updateProduct(int productId, GroceryProductModel updatedProduct) async {
    try {
      isLoading.value = true;
      await repository.updateProduct(productId, updatedProduct);
      int index = products.indexWhere((p) => p.productId == productId);
      if (index != -1) {
        products[index] = updatedProduct;
        Get.snackbar('Success', 'Product updated successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    } finally {
      isLoading.value = false;
    }
  }

// Delete product
  Future<void> deleteProduct(int productId) async {
    try {
      isLoading.value = true;
      await repository.deleteProduct(productId);
      products.removeWhere((p) => p.productId == productId);
      Get.snackbar('Success', 'Product deleted successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
