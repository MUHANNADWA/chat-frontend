import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/features/shop/services/shop_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  static ProductsController get instance => Get.find();

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  RxList<Product> products = <Product>[].obs;

  @override
  onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async =>
      products.firstRebuild ? await fetchProducts() : DoNothingAction();

  Future<void> refreshProducts() async => await fetchProducts();

  Future<void> fetchProducts() async {
    try {
      log('Fetching Products 🔄');
      isLoading.value = true;
      hasError.value = false;

      final data = await ShopService.getProducts();
      final List<dynamic> productsData = data['data'];

      products.value = List.generate(
        productsData.length,
        (index) => Product.fromJson(productsData[index]),
      );

      products.refresh();

      log('Products Fetched Successfully ✅ response = ${products.map((product) => product.toJson())}');
    } catch (e) {
      log('Error Fetching Products ❌ error = $e');

      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
