import 'package:chatbotstudy/common/pages/app_default_page.dart';
import 'package:chatbotstudy/common/pages/no_internet_connention_page.dart';
import 'package:chatbotstudy/features/authentication/screens/signup/success_screen.dart';
import 'package:flutter/material.dart';
import '/utils/popups_loaders/circular_loader.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class AppDialogs {
  // Full Screen Loading Dialog
  static void showFullScreenLoadingDialog(
    String title,
    String subTitle,
    String image,
  ) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: AppColors.darkLight,
          child: Column(
            children: [
              AppDefaultPage(
                image: image,
                title: title,
                subTitle: subTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Loading dialog
  static void showLoadingDialog() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => const PopScope(
        canPop: true,
        child: AppCircularLoader(),
      ),
    );
  }

  // No Internet Dialog
  static void showNoInternetDialog() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: AppColors.darkLight,
          child: const NoInternetConnentionPage(),
        ),
      ),
    );
  }

  static void showSuccessDialog(
    String title,
    String subTitle,
    String image,
    VoidCallback onPressed,
  ) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: AppColors.darkLight,
          child: SuccessScreen(
            title: title,
            subTitle: subTitle,
            image: image,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  // Confirmation Dialog
  static void showConfirmationDialog({
    required String title,
    required String description,
    required String confirmText,
    required void Function()? onConfirm,
  }) {
    Get.defaultDialog(
      buttonColor: AppColors.primary,
      confirmTextColor: AppColors.white,
      cancelTextColor: AppColors.darkLightInvert,
      title: confirmText,
      middleText: description,
      textCancel: 'Cancel',
      textConfirm: confirmText,
      onConfirm: onConfirm,
    );
  }

  // Hide Current Dialog
  static hideDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
