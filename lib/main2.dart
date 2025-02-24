import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/chat/chat_controller.dart';
import 'app/modules/chat/chat_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ChatGPT Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/chat',
      getPages: [
        GetPage(
          name: '/chat',
          page: () => const ChatView(),
          binding: BindingsBuilder.put(() => ChatController()),
        ),
      ],
    );
  }
}