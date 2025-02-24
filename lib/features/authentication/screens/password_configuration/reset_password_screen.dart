import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatbotstudy/utils/constants/pages.dart';
import 'package:get/get.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.clear),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              Image.asset(
                AppImages.deliveredEmail,
                width: AppHelper.screenWidth * 0.6,
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Title
              Text(
                AppTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.spaceBtwItems),

              // SubTitle
              Text(
                AppTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(loginScreen),
                  child: Text(AppTexts.done),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems),

              // Resend Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Get.toNamed(loginScreen),
                  child: Text(AppTexts.resendEmail),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
