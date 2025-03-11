import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/features/shop/controllers/chat/chat_controller.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
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
        title: Center(child: const Text('AI Teacher')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(8.0),
                // reverse: true,
                controller: controller.scrollController,
                itemCount: controller.messages.length + 1,
                itemBuilder: (context, index) =>
                    index == controller.messages.length
                        ? !controller.sisLoading.value
                            ? const SizedBox()
                            : SizedBox(
                                height: 80,
                                child: Align(
                                    alignment: Alignment(-0.9, 0),
                                    child: CircularProgressIndicator()),
                              )
                        : _ChatBubble(
                            message: controller.messages[index],
                            formatTime: controller.formatTime,
                          ),
              ),
            ),
          ),
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
        children: [
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message.isUser ? 'You' : 'AI Teacher',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      formatTime(message.timestamp),
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(AppSizes.sm),
                  decoration: BoxDecoration(
                      color: AppColors.darkContainer,
                      borderRadius: BorderRadius.circular(AppSizes.sm)),
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(message.text),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.lg),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md, vertical: AppSizes.sm),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              onSubmitted: (_) => controller.sendMessage(),
              decoration: InputDecoration(
                hintText: 'Send a message...',
                enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                filled: true,
                fillColor: AppColors.darkContainer,
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
          SizedBox(width: AppSizes.sm),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller.textController,
            builder: (context, value, child) {
              return CircleAvatar(
                backgroundColor: AppColors.primary,
                child: IconButton(
                  color: AppColors.white,
                  icon: value.text.isEmpty
                      ? const Icon(Iconsax.microphone)
                      : const Icon(Iconsax.send_1),
                  onPressed: () {
                    if (value.text.isEmpty) {
                      // _startVoiceInput();
                    } else {
                      controller.sendMessage();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
