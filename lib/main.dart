import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:chatbotstudy/utils/background_services/background_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chatbotstudy/app.dart';

void main() async {
  // Initialize Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Environment Variables
  await dotenv.load();

  // Initialize Get Storage
  await GetStorage.init();

  // To Delete Everything In Storage
  // GetStorage().erase();

  // Run App
  runApp(const App());
}
