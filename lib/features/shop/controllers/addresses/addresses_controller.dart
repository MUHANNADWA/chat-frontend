import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/shop/models/site_model.dart';
import 'package:chatbotstudy/features/shop/services/shop_service.dart';
import 'package:chatbotstudy/utils/popups_loaders/loaders.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<Site> addresses = <Site>[].obs;

  Future<void> getSites() async =>
      addresses.firstRebuild ? await fetchSites() : DoNothingAction();

  Future<void> refreshSites() async => await fetchSites();

  Future<void> fetchSites() async {
    try {
      log('Fetching Sites 🔄');
      isLoading.value = true;
      hasError.value = false;

      final data = await ShopService.getSites();
      final addressesData = data['data'];

      addresses.value = List.generate(
        addressesData.length,
        (index) => Site.fromJson(addressesData[index]),
      );

      addresses.refresh();

      log('Sites Fetched Successfully ✅ response = ${addresses.map((product) => product.toJson())}');
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();

      log('Error Fetching Sites ❌ error = $e');
    } finally {
      isLoading.value = false;
    }
  }

  final name = TextEditingController();
  final address = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addSite() async {
    try {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;
      hasError.value = false;

      final siteData = {
        'name': name.text.trim(),
        'address': address.text.trim()
      };

      await ShopService.addSite(siteData);

      AppLoaders.successSnackBar(
          title: 'Added', message: 'Your Address has been added successfully!');

      addresses.refresh();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  final editName = TextEditingController();
  final editAddress = TextEditingController();

  Future<void> editSite(id) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final siteData = {
        'name': editName.text.trim(),
        'address': editAddress.text.trim()
      };

      await ShopService.updateSiteById(id, siteData);

      AppLoaders.successSnackBar(
          title: 'Updated',
          message: 'Your Address has been updated successfully!');

      addresses.refresh();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSiteById(id) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      await ShopService.deleteSiteById(id);

      AppLoaders.errorSnackBar(
          title: 'Removed',
          message: 'Your Address has been Removed successfully!');
      addresses.refresh();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // ------------
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final TextEditingController textController = TextEditingController();
  final String _apiKey = 'YOUR_OPENAI_API_KEY';
  final String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  void sendMessage() async {
    if (textController.text.isEmpty) return;

    final text = textController.text;
    textController.clear();

    // Add user message
    messages.add(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': text}
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final botResponse = jsonResponse['choices'][0]['message']['content'];

        messages.add(ChatMessage(
          text: botResponse,
          isUser: false,
          timestamp: DateTime.now(),
        ));
      } else {
        Get.snackbar(
            'Error', 'Failed to fetch response: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  String formatTime(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp);
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
