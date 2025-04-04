import 'package:flutter/material.dart';
import 'package:chatbotstudy/utils/constants/pages.dart';
import 'package:chatbotstudy/utils/validator/validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chatbotstudy/common/widgets/login_signup/international_phone_number_input_field.dart';
import 'package:chatbotstudy/features/authentication/controllers/login/login_controller.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.xl),
        child: Obx(
          () => Column(
            children: [
              const InternationalPhoneNumberInputField<LoginController>(),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              // Password
              TextFormField(
                controller: controller.password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    AppValidator.validateEmptyText(AppTexts.password, value),
                decoration: InputDecoration(
                  labelText: AppTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: controller.passwordIcon.value,
                    onPressed: () => controller.togglePasswordVisibility(),
                  ),
                ),
                obscureText: controller.isPasswordObscured.value,
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

              // Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Forgot Password
                  TextButton(
                    onPressed: () => Get.toNamed(forgotPasswordScreen),
                    child: Text(AppTexts.forgotPassword),
                  )
                ],
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async => await controller.login(),
                  child: Text(AppTexts.signIn),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(signupScreen),
                  child: Text(AppTexts.createAccount),
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
