import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chatbotstudy/features/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chatbotstudy/utils/popups_loaders/loaders.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  // ------------

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final String _apiUrl = 'http://192.168.187.41:8000/api/chat/ask';

  final RxString _partialAnswer = ''.obs;
  final RxBool sisLoading = false.obs;

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

    _partialAnswer.value = '';
    sisLoading.value = true;

    final client = HttpClient();
    try {
      final request = await client.postUrl(Uri.parse(_apiUrl));
      request.headers.contentType = ContentType.json;
      request.headers.add('Authorization', 'Bearer ${AuthService.token}');

      final body = jsonEncode({'question': text});
      request.write(body);
      final response = await request.close();

      if (response.statusCode != 200) {
        throw HttpException('HTTP ${response.statusCode}');
      }

      final transformer = StreamTransformer<List<int>, String>.fromHandlers(
        handleData: (data, sink) {
          sink.add(utf8.decode(data));
        },
      );
      await for (final line in response.transform(transformer)) {
        for (final subline in const LineSplitter().convert(line)) {
          if (subline.startsWith('data: ')) {
            final chunk = subline.substring(6); // Remove "data: "
            _partialAnswer.value += chunk;
          }
        }
      }

      // Add bot response to messages once streaming completes
      messages.add(ChatMessage(
        text: _partialAnswer.value,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to fetch response: $e');
    } finally {
      sisLoading.value = false;
      client.close();
    }

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  String formatTime(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp);
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
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
