import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/features/shop/controllers/addresses/addresses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      appBar: AppAppBar(
        title: const Text('Chat With Your Ai Teacher'),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: false,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) => _ChatBubble(
                  message: controller.messages[index],
                  formatTime: controller.formatTime,
                ),
              ),
            ),
          ),
          const Divider(height: 1.0),
          _MessageInput(controller: controller),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final String Function(DateTime) formatTime;

  const _ChatBubble({
    required this.message,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: message.isUser ? Colors.blue : Colors.grey,
            child: Text(message.isUser ? 'You' : 'AI'),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message.isUser ? 'You' : 'ChatGPT',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      formatTime(message.timestamp),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(message.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final ChatController controller;

  const _MessageInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              onSubmitted: (_) => controller.sendMessage(),
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
          IconButton(
            icon: controller.textController.text.isEmpty
                ? const Icon(Iconsax.voice_cricle)
                : const Icon(Iconsax.send_1),
            onPressed: controller.sendMessage,
          ),
        ],
      ),
    );
  }
}
