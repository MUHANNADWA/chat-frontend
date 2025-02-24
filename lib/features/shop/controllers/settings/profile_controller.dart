import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/authentication/models/user_model.dart';
import 'package:chatbotstudy/features/authentication/services/auth_service.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/pages.dart';
import 'package:chatbotstudy/utils/popups_loaders/app_dialogs.dart';
import 'package:chatbotstudy/utils/popups_loaders/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  RxBool isPasswordObscured = true.obs;
  Rx<Icon> passwordIcon = const Icon(Iconsax.eye).obs;

  // Toggle Password
  togglePasswordVisibility() {
    isPasswordObscured.toggle();
    passwordIcon.value = isPasswordObscured.value
        ? const Icon(Iconsax.eye)
        : const Icon(Iconsax.eye_slash);
  }

  // Variables
  final firstName =
      TextEditingController(text: AuthService.currentUser.firstName);
  final lastName =
      TextEditingController(text: AuthService.currentUser.lastName);
  final username =
      TextEditingController(text: AuthService.currentUser.fullName);
  final email = TextEditingController(text: AuthService.currentUser.fatherName);
  final phone = TextEditingController(text: AuthService.currentUser.phone);
  final password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> updateUserInfo({File? profileImage}) async {
    try {
      // Form Validation
      if (!formKey.currentState!.validate()) return;

      // Start Loading
      AppDialogs.showFullScreenLoadingDialog(
        'Updating your Profile..',
        'Working behind the scenes to get things ready.',
        AppImages.loading,
      );

      final userData = {
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'username': username.text.trim(),
        'email': email.text.trim(),
        'phone': phone.text.trim(),
        'password': password.text.trim(),
      };

      Map? responseImage;
      if (profileImage != null) {
        responseImage = await AuthService.updateUserImage(profileImage);
      }
      final response = await AuthService.updateUser(userData);

      final user = User.fromJson(response['data']['user']);
      user.image = responseImage?['data']['icon_url'] ?? AppImages.user;

      await GetStorage().write('user', user.toJson());

      // Stop Loading
      AppDialogs.hideDialog();

      AppLoaders.infoSnackBar(
          title: 'Saved!', message: 'Your Info Has Been Updated');
    } catch (e) {
      await AppDialogs.hideDialog();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      AppDialogs.showConfirmationDialog(
        title: 'Confirm Logout',
        description:
            'Are you sure you want to Log out? This action will end your session now.',
        confirmText: 'Logout',
        onConfirm: () async {
          try {
            await AuthService.logout();
          } catch (e) {
            log('loguot error: $e');
          }
          GetStorage().remove('token');
          Get.offAllNamed(loginScreen);
        },
      );
    } catch (e) {
      await AppDialogs.hideDialog();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> deleteAccount(id) async {
    try {
      AppDialogs.showConfirmationDialog(
        title: 'Confirm Deletion',
        description:
            'Are you sure you want to delete your account? This action cannot be undone.',
        confirmText: 'Delete',
        onConfirm: () async {
          Get.back();
          await AuthService.deleteUserById(id);
          AppLoaders.errorSnackBar(
              title: 'Deleted!',
              message:
                  'Your Account Has been Deleted Successfully, Your Session Will end soon');
          Get.offAllNamed(loginScreen);
        },
      );
    } catch (e) {
      await AppDialogs.hideDialog();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
