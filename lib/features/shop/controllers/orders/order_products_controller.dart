import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/features/shop/services/shop_service.dart';
import 'package:get/get.dart';

class OrderItemsController extends GetxController {
  static OrderItemsController get instance => Get.find();

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxMap<int, Map<Product, int>> orderItems =
      <int, Map<Product, int>>{}.obs;

  Future<void> getOrderItemsByOrderId(id) async => !orderItems.containsKey(id)
      ? await fetchOrderItemsByOrderId(id)
      : DoNothingAction();

  Future<void> refreshOrderItemsByOrderId(id) async =>
      await fetchOrderItemsByOrderId(id);

  Future<void> fetchOrderItemsByOrderId(id) async {
    try {
      log('Fetching Items For The Order With Id: $id 🔄');

      isLoading.value = true;
      hasError.value = false;

      final data = await ShopService.getOrderById(id);
      final orderItemsData = data['data']['products'];

      for (var item in orderItemsData) {
        final productData = await ShopService.getProductById(item['id']);
        final product = Product.fromJson(productData['data']);
        final quantity = item['quantity'];

        if (!orderItems.containsKey(id)) {
          orderItems[id] = {};
        }
        orderItems[id]![product] = quantity;
      }

      log('Items For The Order With Id: $id Fetched Successfully ✅  response = ${orderItems.map((orderId, products) => MapEntry(orderId, products.map((product, quantity) => MapEntry(product.toJson(), quantity))))}');
    } catch (e) {
      log('Error Fetching Items For The Order With Id: $id ❌ error = $e');

      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
