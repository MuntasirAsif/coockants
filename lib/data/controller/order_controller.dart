import 'package:get/get.dart';
import '../models/order_model.dart';
import '../repositories/order_repositroy.dart';

class OrderController extends GetxController {
  final OrderRepository repository = OrderRepository();
  RxList<Order> orders = <Order>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      List<Order> fetchedOrders = await repository.getAllOrders();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      await repository.createOrder(order);
      fetchOrders();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add order: $e');
    }
  }

  Future<void> updateOrder(int id, Order order) async {
    try {
      await repository.updateOrder(id, order);
      fetchOrders();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update order: $e');
    }
  }

  Future<void> deleteOrder(int id) async {
    try {
      await repository.deleteOrder(id);
      fetchOrders();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete order: $e');
    }
  }
}
