import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/features/shop/services/shop_service.dart';
import 'package:get/get.dart';

class StoreProductsController extends GetxController {
  static StoreProductsController get instance => Get.find();

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxMap<int, List<Product>> storeProducts = <int, List<Product>>{}.obs;

  Future<void> getStoreProductsByStoreId(id) async =>
      !storeProducts.containsKey(id)
          ? await fetchStoreProductsByStoreId(id)
          : DoNothingAction();

  Future<void> refreshStoreProductsByStoreId(id) async =>
      await fetchStoreProductsByStoreId(id);

  Future<void> fetchStoreProductsByStoreId(id) async {
    try {
      log('Fetching Products For The Store With Id: $id 🔄');

      isLoading.value = true;
      hasError.value = false;

      final data = await ShopService.getStoreProductsByStoreId(id);
      final storeProductsData = data['data'];

      storeProducts[id] = List.generate(
        storeProductsData.length,
        (index) => Product.fromJson(storeProductsData[index]),
      );

      log('Products For The Store With Id: $id Fetched Successfully ✅  response = ${storeProducts.map((storeId, products) => MapEntry(storeId, products.map((product) => product.toJson())))}');
    } catch (e) {
      log('Error Fetching Products For The Store With Id: $id ❌ error = $e');

      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
