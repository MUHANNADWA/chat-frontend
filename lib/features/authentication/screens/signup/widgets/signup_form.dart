import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/authentication/controllers/signup/signup_controller.dart';
import 'package:chatbotstudy/utils/validator/validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chatbotstudy/common/widgets/login_signup/international_phone_number_input_field.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              // First Name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      AppValidator.validateEmptyText(AppTexts.firstName, value),
                  decoration: InputDecoration(
                    labelText: AppTexts.firstName,
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),

              const SizedBox(width: AppSizes.spaceBtwInputFields),

              // Last Name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      AppValidator.validateEmptyText(AppTexts.lastName, value),
                  decoration: InputDecoration(
                    labelText: AppTexts.lastName,
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          // Father Name
          TextFormField(
            controller: controller.fatherName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
                AppValidator.validateEmptyText('Father Name', value),
            decoration: InputDecoration(
              labelText: 'Father Name',
              prefixIcon: const Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          // Mother Name
          TextFormField(
            controller: controller.motherName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
                AppValidator.validateEmptyText('Mother Name', value),
            decoration: InputDecoration(
              labelText: 'Mother Name',
              prefixIcon: const Icon(Iconsax.user),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          // Phone Number
          const InternationalPhoneNumberInputField<SignupController>(),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          // Father Phone Number
          InternationalPhoneNumberInputField<SignupController>(
            labelText: 'Father Number',
            onInputChanged: (PhoneNumber number) =>
                controller.fatherPhoneNumber.value = number.phoneNumber ?? '',
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => AppValidator.validatePassword(value),
              obscureText: controller.isPasswordObscured.value,
              decoration: InputDecoration(
                labelText: AppTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: controller.passwordIcon.value,
                  onPressed: () => controller.togglePasswordVisibility(),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          // Password Confirmation
          Obx(
            () => TextFormField(
              controller: controller.passwordConfirmation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => AppValidator.validatePasswordConfirmation(
                  value, controller.password.text),
              obscureText: controller.isPasswordConfirmationObscured.value,
              decoration: InputDecoration(
                labelText: AppTexts.passwordConfirmation,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: controller.passwordConfirmationIcon.value,
                  onPressed: () =>
                      controller.togglePasswordConfirmationVisibility(),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwSections),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(AppTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
