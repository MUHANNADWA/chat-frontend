import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chatbotstudy/features/authentication/models/user_model.dart';
import 'package:chatbotstudy/features/authentication/services/auth_service.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/pages.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:chatbotstudy/utils/popups_loaders/app_dialogs.dart';
import 'package:chatbotstudy/utils/popups_loaders/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

enum LoginScreen { phoneNumber, facebook, google }

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //* Current Screen State
  final Rx<LoginScreen> currentScreen = LoginScreen.phoneNumber.obs;

  // Change Screen
  void setLoginScreen(LoginScreen screen) {
    currentScreen.value = screen;
  }

  //* Toggle Password
  RxBool isPasswordObscured = true.obs;
  Rx<Icon> passwordIcon = const Icon(Iconsax.eye).obs;

  // Toggle Password
  togglePasswordVisibility() {
    isPasswordObscured.toggle();
    passwordIcon.value = isPasswordObscured.value
        ? const Icon(Iconsax.eye)
        : const Icon(Iconsax.eye_slash);
  }

  //* Login Variables
  RxString phoneNumber = ''.obs;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //* Login
  Future<void> login() async {
    try {
      // Form Validation
      if (!loginFormKey.currentState!.validate()) return;

      // Start Loading
      AppDialogs.showFullScreenLoadingDialog(
        'Processing your request..',
        'Working behind the scenes to get things ready.',
        AppImages.loading,
      );

      final userData = {
        'phone': phoneNumber.value,
        'password': password.text.trim()
      };

      User user;
      // Login User
      if (dotenv.env['ENV']?.trim() != 'development') {
        final response = await AuthService.login(userData);

        user = User.fromJson(response['user']);
        // user = User.fromJson(AppHelper.exampleUser.toJson());

        await GetStorage().write('user', user.toJson());

        // Store User Status
        await GetStorage().write('token', response['token']);
        // await GetStorage().write('token', '12|Qvjk8sdvnioDSVniklnsvda2dvsk');
      }

      AppHelper.hideKeyboard();

      // Stop Loading
      await AppDialogs.hideDialog();

      // Navigate To Navigation Menu
      Get.offAllNamed(mainScreen);
    } catch (e) {
      AppDialogs.hideDialog();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
